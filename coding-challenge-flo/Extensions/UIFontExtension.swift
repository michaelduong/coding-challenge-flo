//
//  UIFontExtension.swift
//  coding-challenge-flo
//
//  Created by Michael Duong on 5/11/19.
//  Copyright © 2019 Turnt Labs. All rights reserved.
//

import UIKit

extension UIFont {
    convenience init(name fontName: FontNameConvertible, size fontSize: CGFloat) {
        self.init(name: fontName.rawValue, size: fontSize)!
    }
}
