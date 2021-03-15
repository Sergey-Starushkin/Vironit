//
//  HistoryTableViewCell.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 11.03.21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var mounthLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    static func nib() -> UINib {
        return UINib(nibName: "HistoryTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String, day: String, mounth: String){
        dayLabel.text = day
        mounthLabel.text = mounth
        nameLabel.text = title
    }

}
