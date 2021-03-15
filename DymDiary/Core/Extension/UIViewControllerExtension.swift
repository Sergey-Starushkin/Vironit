//
//  UIViewControllerExtension.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 9.02.21.
//

import UIKit

extension UIViewController{
    
    func warning(title: String? = nil, message: String? = nil, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getMonth() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.shortMonthSymbols
        let dateString = dateFormatter.string(from: date)
        return month?[(Int(dateString) ?? 0) - 1] ?? ""
    }
    func getDay() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}
