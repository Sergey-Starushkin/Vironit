//
//  SettingsTableViewCell.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 8.03.21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    static func nib() -> UINib {
        return UINib(nibName: "SettingsTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String){
        titleLabel.text = title
    }
    
}
