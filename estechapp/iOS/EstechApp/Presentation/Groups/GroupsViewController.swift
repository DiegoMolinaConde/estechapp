//
//  GroupsViewController.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 29/05/24.
//

import Foundation
import UIKit
import BDRModel
class GroupsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameGroupLabel: UILabel!
    @IBOutlet weak var imageGroups: UIImageView!
    @IBOutlet weak var numberGroupsLabel: UILabel!
    
    func setup(_ data: Group) {
        nameGroupLabel.text = data.name
        numberGroupsLabel.text = data.numberStudents.description
        imageGroups.image = data.image
    }
}
class GroupsViewController: UIViewController {
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups: [Group] = [
        .init(type: "Animaciones", numberGroup: 1, numberStudents: 14),
        .init(type: "Animaciones", numberGroup: 2, numberStudents: 23),
        .init(type: "DAM", numberGroup: 1, numberStudents: 45),
        .init(type: "DAM", numberGroup: 2, numberStudents: 75),
        .init(type: "ASIR", numberGroup: 1, numberStudents: 666),
        .init(type: "ASIR", numberGroup: 2, numberStudents: 777)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.hideBackButton()
        navBar.setTitle("Grupos")
        todayLabel.text = DateFormatter.sharedFormatter.stringFromDate(Date(), withFormat: prettyFormat)
    }
}

extension GroupsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupsCollectionViewCell", for: indexPath) as? GroupsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(groups[indexPath.item])
        return cell
    }
    
    
}
