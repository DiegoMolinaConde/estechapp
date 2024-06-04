//
//  MentoringTableViewCell.swift
//  EstechApp
//
//  Created by Junior Quevedo Gutiérrez  on 17/05/24.
//

import UIKit
import BDRModel
class MentoringTableViewCell: UITableViewCell {

    @IBOutlet weak var hourDate: UILabel!
    @IBOutlet weak var nameStudentLabel: UILabel!
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(_ data: Mentoring) {
        hourDate.text = DateFormatter.sharedFormatter.stringFromDate(
            data.date,
            withFormat: kHour24Formatter
        )
        nameStudentLabel.text = "Estudiante N# \(data.studentId)"
        roomNameLabel.text = "Aula N# \(data.roomId)"
    }

}