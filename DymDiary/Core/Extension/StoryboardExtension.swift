//
//  StoryboardExtension.swift
//  DymDiary
//
//  Created by Sergey Starushkin on 1.02.21.
//

import UIKit

extension UIStoryboard {
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
}
