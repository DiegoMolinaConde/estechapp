//
//  FichajeViewController.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 9/05/24.
//

import UIKit
import BDRUIComponents

protocol FichajeView: AnyObject  {
    func showError(message: String)
    func showLoading(isActive: Bool)
    
    func showName(name: String)
    func showStateCheckIn(isCheckIn: Bool)
}

class FichajeViewController: UIViewController {
    
    @IBOutlet weak var checkInImage: UIImageView!
    @IBOutlet weak var imageCheckin: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tutoriasContent: UIView! {
        didSet {
            tutoriasContent.cornerRadius = 5
            tutoriasContent.layer.borderColor = UIColor(named: "Border")!.cgColor
            tutoriasContent.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var horarioParentContent: UIView! {
        didSet {
            horarioParentContent.layer.borderColor = UIColor(named: "Border")!.cgColor
            horarioParentContent.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var tutoriasTableView: UITableView!
    
    @IBOutlet weak var horarioMorningContent: UIView! {
        didSet {
            horarioMorningContent.layer.borderColor = UIColor(named: "Border")!.cgColor
            horarioMorningContent.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var horarioNocheContent: UIView!{
        didSet {
            horarioNocheContent.layer.borderColor = UIColor(named: "Border")!.cgColor
            horarioNocheContent.layer.borderWidth = 1
        }
    }
    
    var presenter: FichajePresenter = FichajePresenterDefault()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.fetchTutorias()
        presenter.fetchHorarios()
        presenter.fetchInfoUser()
    }
    
    
    @IBAction func checkInDidSelect(_ sender: Any) {
        presenter.fetchAddCheckin()
    }
    
    
}

extension FichajeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension FichajeViewController: FichajeView {
    func showStateCheckIn(isCheckIn: Bool) {
        checkInImage.image = UIImage(named: isCheckIn ? "salida" : "entrada")
    }
    
    func showName(name: String) {
        nameLabel.text = name
    }
    
    func showError(message: String) {
        showErrorMessage(message: message)
    }
    
    func showLoading(isActive: Bool) {
        if isActive {
            displayAnimatedActivityIndicatorView()
        } else {
            hideAnimatedActivityIndicatorView()
        }
    }
}
