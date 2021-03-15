import UIKit

enum AppFont {

    static var fontNames = [
        "SFCompactRounded-Bold",
        "SFCompactRounded-Regular",
        "SFCompactRounded-Medium"
    ]
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: fontNames[0], size: size)!
    }
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: fontNames[1], size: size)!
    }
    
    static func medium(size: CGFloat) -> UIFont {
        return UIFont(name: fontNames[2], size: size)!
    }
    
}
