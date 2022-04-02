//
//  Styles.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 3/4/22.
//  Copyright © 2022 Methas Tariya. All rights reserved.
//

import Foundation
import UIKit

enum Style {
    enum Color {
        case yellow
        case red
        case green
        case blue
        case text
        case secondaryText
        case placeholder
        case error
        
        var uiColor: UIColor {
            switch self {
            case .yellow: return UIColor(red: 1.0, green: 0.878, blue: 0.4, alpha: 1.0) // #ffe066
            case .red: return UIColor(red: 0.949, green: 0.373, blue: 0.361, alpha: 1.0) // #f25f5c
            case .green: return UIColor(red: 0.392, green: 0.745, blue: 0.569, alpha: 1.0)// #64be91
            case .blue: return UIColor(red: 0.235, green: 0.569, blue: 0.902, alpha: 1.0) // #3c91e6
            case .text: return UIColor(red: 0.204, green: 0.180, blue: 0.216, alpha: 1.0) // #342e37
            case .secondaryText: return UIColor(red: 0.6, green: 0.588, blue: 0.608, alpha: 1.0) // #99969b
            case .placeholder: return UIColor(red: 0.882, green: 0.886, blue: 0.902, alpha: 1.0) // #e1e2e6
            case .error: return UIColor(red: 0.965, green: 0.565, blue: 0.557, alpha: 1.0) // #f6908e
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .yellow: return Color.text.uiColor
            default: return .white
            }
        }
    }
    
    enum Font {
        case museoRounded(_ size: CGFloat)
        case museoRoundedBold(_ size: CGFloat)
        case museoRoundedBlack(_ size: CGFloat)
        case ibmPlexSans(_ size: CGFloat)
        case ibmPlexSansBold(_ size: CGFloat)
        
        var font: UIFont {
            switch self {
            case let .museoRounded(size): return .init(name: "Museo Sans Rounded 500", size: size)!
            case let .museoRoundedBold(size): return .init(name: "Museo Sans Rounded 700", size: size)!
            case let .museoRoundedBlack(size): return .init(name: "Museo Sans Rounded 900", size: size)!
            case let .ibmPlexSans(size): return .init(name: "IBMPlexSansThai-Regular", size: size)!
            case let .ibmPlexSansBold(size): return .init(name: "IBMPlexSansThai-Bold", size: size)!
            }
        }
    }
    
    static func applyNavStyles(of navCtrl: UINavigationController?, color: Color) {
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = color.uiColor
            appearance.titleTextAttributes = [
                .foregroundColor: color.textColor,
                .font: Font.museoRoundedBold(17).font
            ]
            navCtrl?.navigationBar.standardAppearance = appearance
            navCtrl?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        navCtrl?.view.backgroundColor = color.uiColor
    }
}
