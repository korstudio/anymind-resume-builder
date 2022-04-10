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
        case border
        
        var uiColor: UIColor {
            switch self {
            case .yellow: return "#ffe066".uiColor
            case .red: return "#f25f5c".uiColor
            case .green: return "#64be91".uiColor
            case .blue: return "#3c91e6".uiColor
            case .text: return "#342e37".uiColor
            case .secondaryText: return "#99969b".uiColor
            case .placeholder: return "#e1e2e6".uiColor
            case .error: return "#f6908e".uiColor
            case .border: return "#e1e2e6".uiColor
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
