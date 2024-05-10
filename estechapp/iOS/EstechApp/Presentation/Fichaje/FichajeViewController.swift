//
//  FichajeViewController.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 9/05/24.
//

import UIKit
class FichajeViewController: UIViewController {
    
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
    
    
}

extension FichajeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
