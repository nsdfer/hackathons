//
//  LanguageType.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import Foundation

enum LanguageType: String, CaseIterable {
    case english = "en"
    case chinese = "zh-cn"
    case vietnamese = "vi"
    case spanish = "es"
    
    var title: String {
        switch self {
        case .english:
            return "English"
        case .chinese:
            return "Chinese"
        case .vietnamese:
            return "Vietnamese"
        case .spanish:
            return "Spanish"
        }
    }
}
