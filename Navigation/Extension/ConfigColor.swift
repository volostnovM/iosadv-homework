//
//  ConfigColor.swift
//  Navigation
//
//  Created by TIS Developer on 17.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode}    }
}

extension UIColor {
    class var myWhiteColor: UIColor {
        return UIColor(red: 255.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    }
    class var myBlackColor: UIColor {
        return UIColor(red: 5.0/255.0, green: 5.0/255.0, blue: 5.0/255.0, alpha: 1.0)
    }
    class var myGrayColor: UIColor {
        return UIColor(red: 105.0/255.0, green: 105.0/255.0, blue: 105.0/255.0, alpha: 1.0)
    }
    class var myGreenColor: UIColor {
        return UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1.0)
    }
    class var myOrangeColor: UIColor {
        return UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
}
