//
//  Realm.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import RealmSwift

class RealmHelper {
    static let shared = RealmHelper()
    
    let realm = try! Realm()
    
    func save(object: Object) {
        try! realm.write() {
            realm.add(object)
        }
    }
}
