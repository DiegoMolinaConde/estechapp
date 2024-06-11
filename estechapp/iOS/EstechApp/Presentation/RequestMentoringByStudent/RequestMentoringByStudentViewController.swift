//
//  RequestMentoringByStudentViewController.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 11/06/24.
//

import UIKit
import BDRModel
protocol RequestMentoringByStudentView: AnyObject {
    func showMentorings(_ data: [Mentoring])
    func createMentoringSuccess()
    func cancelMentoringSuccess()
    func showLoading(isActive: Bool)
    func showErrorMessage(_ msg: String)
}

class RequestMentoringTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var cancelDidSelect: UIButton!
    
    func populate(_ data: Mentoring) {
        hourLabel.text = DateFormatter.sharedFormatter.stringFromDate(
            data.date,
            withFormat: kHour24Formatter
        )
        nameLabel.text = data.teacher.fullName
        dateLabel.text = DateFormatter.sharedFormatter.stringFromDate(
            data.date,
            withFormat: prettyFormat
        )
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
    }
}
class RequestMentoringByStudentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var teacherId: String? = nil
    var dateSelect: Date? = nil
    var auxtextField: UITextField?
    let presenter = RequestMentoringByStudentPresenterDefault()
    var teacherMentoring: [Mentoring] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.fetchMentorings()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didRequestNew(_ sender: Any) {
        didEditSelect()
    }

    
    func didEditSelect() {
        let hourPicker = UIDatePicker()
        hourPicker.datePickerMode = .dateAndTime
        if #available(iOS 14, *) {
            hourPicker.preferredDatePickerStyle = .wheels
        }
        hourPicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)


        let alert = UIAlertController(title: "Pedir tutoría", message: "", preferredStyle: .alert)

        alert.addTextField {(textField) in
            self.auxtextField = textField
            textField.inputView = hourPicker
            textField.placeholder = "Hora de la tutoría"
        }
        alert.addTextField {(textField) in
            textField.placeholder = "Profesor"
        }
        alert.addTextField {(textField) in
            textField.placeholder = "Aula"
        }
      //  alert.view.addSubview(datePicker)
        let alertActionOk = UIAlertAction(title: "Confirmar", style: .default) { action in
            //actionBlock?()
            
            guard let safeDate = self.dateSelect else {
                self.showErrorMessage(message: "Seleccione una fecha y hora")
                return
            }
            
            guard let teacher = alert.textFields?[1].text, !teacher.isEmpty else {
                self.showErrorMessage(message: "Ingrese el Profesor")
                return
            }
            guard let room = alert.textFields?[2].text, !room.isEmpty else {
                self.showErrorMessage(message: "Ingrese el Aula")
                return
            }
            
            
            self.presenter.createNewMentoring(date: safeDate, roomId: room, teacher: teacher)        }
        let alertActionCancel = UIAlertAction(title: "Cancelar", style: .destructive) { action in
            
        }
        alert.addAction(alertActionOk)
        alert.addAction(alertActionCancel)
        self.present(alert, animated: true)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
          let dateFormatter = DateFormatter()
            
          dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
            dateSelect = sender.date
        auxtextField?.text = dateFormatter.string(from: sender.date)
         // fieldValueTextField.text = dateFormatter.string(from: sender.date)
     }

}


extension RequestMentoringByStudentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teacherMentoring.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestMentoringTableViewCell", for: indexPath) as? RequestMentoringTableViewCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = indexPath.row%2 == 0 ? .white : .lightGray
        cell.selectionStyle = .none
        cell.populate(teacherMentoring[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
extension RequestMentoringByStudentViewController: RequestMentoringByStudentView {
    func cancelMentoringSuccess() {
        presenter.fetchMentorings()
    }
    
    func showMentorings(_ data: [Mentoring]) {
        self.teacherMentoring = data
    }
    
    func createMentoringSuccess() {
        presenter.fetchMentorings()
    }
    
    func showLoading(isActive: Bool) {
        isActive ? displayAnimatedActivityIndicatorView() : hideAnimatedActivityIndicatorView()
    }
    
    func showErrorMessage(_ msg: String) {
        self.showErrorMessage(message: msg)
    }
}
