//
//  Icon.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public enum Icon {}

public protocol IconRepresentable: CaseIterable {
    var name: String { get }
}

public extension Icon {
    
    // MARK: - Chevron
    
    enum Chevron: IconRepresentable {
        case upBig
        case upMedium
        case upSmall
        case downBig
        case downMedium
        case downSmall
        case leftBig
        case leftMedium
        case leftSmall
        case rightBig
        case rightMedium
        case rightSmall
        
        public var name: String {
            switch self {
                case .upBig: return "chevron_up_big"
                case .upMedium: return "chevron_up_medium"
                case .upSmall: return "chevron_up_small"
                case .downBig: return "chevron_down_big"
                case .downMedium: return "chevron_down_medium"
                case .downSmall: return "chevron_down_small"
                case .leftBig: return "chevron_left_big"
                case .leftMedium: return "chevron_left_medium"
                case .leftSmall: return "chevron_left_small"
                case .rightBig: return "chevron_right_big"
                case .rightMedium: return "chevron_right_medium"
                case .rightSmall: return "chevron_right_small"
            }
        }
    }
    
    // MARK: - Checkmark
    
    enum Checkmark: IconRepresentable {
        case falseFill20
        case falseFill24
        case falseLine20
        case falseLine24
        case trueFill20
        case trueFill24
        
        public var name: String {
            switch self {
            case .falseFill20: return "checkmark_false_fill_20"
            case .falseFill24: return "checkmark_false_fill_24"
            case .falseLine20: return "checkmark_false_line_20"
            case .falseLine24: return "checkmark_false_line_24"
            case .trueFill20: return "checkmark_true_fill_20"
            case .trueFill24: return "checkmark_true_fill_24"
            }
        }
    }
    
    // MARK: - CircleAlert
    
    enum CircleAlert: IconRepresentable {
        case fillMono
        
        public var name: String {
            switch self {
            case .fillMono: return "circle_alert_fill_mono"
            }
        }
    }
    
    // MARK: - Close
    
    enum Close: IconRepresentable {
        case fillBlack
        case fillGray
        case fillWhite
        
        public var name: String {
            switch self {
            case .fillBlack: return "close_fill_black"
            case .fillGray: return "close_fill_gray"
            case .fillWhite: return "close_fill_white"
            }
        }
    }

    // MARK: - Edit
    
    enum Edit: IconRepresentable {
        case list
        
        public var name: String {
            switch self {
            case .list: return "edit_list"
            }
        }
    }

    // MARK: - Siren
    
    enum Siren: IconRepresentable {
        case mono
        
        public var name: String {
            switch self {
            case .mono: return "siren_mono"
            }
        }
    }

    // MARK: - Magnifier
    
    enum Magnifier: IconRepresentable {
        case lineGray
        
        public var name: String {
            switch self {
            case .lineGray: return "maginfier_line_gray"
            }
        }
    }

    // MARK: - Arrow
    
    enum Arrow: IconRepresentable {
        case up
        
        public var name: String {
            switch self {
            case .up: return "arrow_up"
            }
        }
    }
    
    // MARK: - Add Circle
    
    enum Add: IconRepresentable {
        case circle
        
        public var name: String {
            switch self {
            case .circle: return "add_circle"
            }
        }
    }
    
    // MARK: - Share
    
    enum Share: IconRepresentable {
        case fillGray
        
        public var name: String {
            switch self {
            case .fillGray: return "share_fill_gray_24"
            }
        }
    }
    
    // MARK: - Trash Can
    
    enum TrashCan: IconRepresentable {
        case fillGray
        
        public var name: String {
            switch self {
            case .fillGray: return "trash_can_fill_gray_24"
            }
        }
    }
    
    // MARK: - Home
    
    enum Home: IconRepresentable {
        case fillGray

        public var name: String {
            switch self {
            case .fillGray: return "home_fill_gray_24"
            }
        }
    }
    
    // MARK: - Medal
    
    enum Medal: IconRepresentable {
        case gold
        case silver
        case bronze
        
        public var name: String {
            switch self {
            case .gold: return "medal_gold"
            case .silver: return "medal_silver"
            case .bronze: return "medal_bronze"
            }
        }
    }
}
