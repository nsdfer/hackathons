//
//  ViewControllerModel.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import UIKit

enum ViewControllersType: String {
    case SignIn = "SignIn"
    case ContactsList = "ContactsList"
    case AddContact = "AddContact"
}

struct ViewControllerModel {
    static func getViewController(type: ViewControllersType) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: type.rawValue)
        
        return viewController
    }
    
    static func getNavigationController(for vcType: ViewControllersType) -> UINavigationController {
        let viewController = getViewController(type: vcType)
        
        return UINavigationController(rootViewController: viewController)
    }
}
