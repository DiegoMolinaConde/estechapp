//
//  MentoringViewController.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 4/06/24.
//

import UIKit
import BDRModel
protocol MentoringView: AnyObject  {
    
    func showMentorings(_ data: [Mentoring])
    func showLoading(isActive: Bool)
}

class AsignedMentoringTableViewCell: UITableViewCell {
    @IBOutlet weak var dateMentoring: UILabel!
    @IBOutlet weak var nameStudent: UILabel!
    
    @IBAction func cancelDidSelect(_ sender: Any) {
    }
    @IBAction func editDidSelect(_ sender: Any) {
    }
    
    func setupData(_ mentoring: Mentoring) {
        nameStudent.text = "Alumno \(mentoring.studentId)"
        dateMentoring.text = DateFormatter.sharedFormatter.stringFromDate(mentoring.date, withFormat: kFormatLocal)
    }
}

class PendingAcceptMentoringTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateMentoring: UILabel!
    @IBOutlet weak var nameStudent: UILabel!
    
    @IBAction func acceptDidSelect(_ sender: Any) {
    }
    
    @IBAction func cancelDidSelect(_ sender: Any) {
    }
    @IBAction func editDidSelect(_ sender: Any) {
    }
    func setupData(_ mentoring: Mentoring) {
        nameStudent.text = "Alumno \(mentoring.studentId)"
        dateMentoring.text = DateFormatter.sharedFormatter.stringFromDate(mentoring.date, withFormat: kFormatLocal)
    }
}

class MentoringViewController: UIViewController {

    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MentoringPresenter = MentoringPresenterDefault()

    
    var mentorings: [Mentoring] = [] {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MentoringViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            mentorings.filter({$0.status == .approved}).count
        } else {
            mentorings.filter({$0.status != .approved}).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AsignedMentoringTableViewCell", for: indexPath) as? AsignedMentoringTableViewCell else {
                return   UITableViewCell()

            }
            cell.setupData(mentorings[indexPath.row])
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PendingAcceptMentoringTableViewCell", for: indexPath) as? PendingAcceptMentoringTableViewCell else {
                return   UITableViewCell()

            }
            cell.setupData(mentorings[indexPath.row])
            return cell
        default:
           return UITableViewCell()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewContainer = UIView()
        viewContainer.backgroundColor = UIColor.white
        let labelHeader = UILabel()
        
        labelHeader.textColor = UIColor.black
        labelHeader.font = .boldSystemFont(ofSize: 16)
        if section == 0 {
            labelHeader.text = "Mis tutorias asignadas"
        }
        if section == 1 {
            labelHeader.text =  "Tutorias pendientes de asignar"
        }
        viewContainer.addSubview(labelHeader)
        labelHeader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        labelHeader.frame = viewContainer.frame
        
        return viewContainer
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }


    
}


extension MentoringViewController: MentoringView {
    func showMentorings(_ data: [Mentoring]) {
        self.mentorings = data
    }
    
    func showLoading(isActive: Bool) {
        isActive ? displayAnimatedActivityIndicatorView() :  hideAnimatedActivityIndicatorView()
    }
    
    
}
