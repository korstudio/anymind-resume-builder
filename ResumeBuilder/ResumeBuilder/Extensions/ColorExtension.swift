//
//  ColorExtension.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 2/4/22.
//  Copyright © 2022 Methas Tariya. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let appYellow = Style.Color.yellow.uiColor
    static let appRed = Style.Color.red.uiColor
    static let appGreen = Style.Color.green.uiColor
    static let appBlue = Style.Color.blue.uiColor
    static let text = Style.Color.text.uiColor
    static let secondaryText = Style.Color.secondaryText.uiColor
    static let placeholder = Style.Color.placeholder.uiColor
    static let error = Style.Color.error.uiColor
}

// HEX String to UIColor
// based on https://stackoverflow.com/a/7180905
extension UIColor {
    convenience init(hex: String) {
        let colorComp: (String, Int, Int) -> CGFloat = { string, start, length in
            let substring = (string as NSString).substring(with: NSRange(location: start, length: length))
            let fullHex = length == 2 ? substring : "\(substring)\(substring)"
            var hexComponent: UInt64 = 0
            Scanner(string: fullHex).scanHexInt64(&hexComponent)
            return CGFloat(Double(hexComponent) / 255.0)
        }
        
        let hexString = hex.replacingOccurrences(of: "#", with: "").uppercased()
        var a: CGFloat = 1.0
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        
        switch (hexString.count) {
        case 3 /* #RGB */:
            r = colorComp(hexString, 0, 1)
            g = colorComp(hexString, 1, 1)
            b = colorComp(hexString, 2, 1)
        case 4 /* #ARGB */:
            a = colorComp(hexString, 0, 1)
            r = colorComp(hexString, 1, 1)
            g = colorComp(hexString, 2, 1)
            b = colorComp(hexString, 3, 1)
        case 6 /* #RRGGBB */:
            r = colorComp(hexString, 0, 2)
            g = colorComp(hexString, 2, 2)
            b = colorComp(hexString, 4, 2)
        case 8 /* #AARRGGBB */:
            a = colorComp(hexString, 0, 2)
            r = colorComp(hexString, 2, 2)
            g = colorComp(hexString, 4, 2)
            b = colorComp(hexString, 6, 2)
        default:
            a = 0
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
