//
//  User.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import RealmSwift

class Myself: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var isVerified: Bool = false
    
    static var current: Myself? {
        return RealmHelper.shared.realm.objects(Myself.self).last
    }
    
    convenience init(id: String) {
        self.init()
        
        self.id = id
    }
    
    static func isVerified() -> Bool {
        guard let myself = Myself.current else {
            return false
        }
        
        return myself.isVerified
    }
    
    func setVerified() {
        try! RealmHelper.shared.realm.write() {
            self.isVerified = true
        }
    }
    
    func save() {
        RealmHelper.shared.save(object: self)
    }
}

class User: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var number: String = ""
    
    static var allUsers: Results<User> {
        return RealmHelper.shared.realm.objects(User.self).sorted(byKeyPath: "firstName", ascending: true)
    }
    
    convenience init(firstName: String, lastName: String, number: String) {
        self.init()
        
        self.firstName = firstName
        self.lastName = lastName
        self.number = number
    }
    
    static func hasContact(number: String) -> Bool {
        return !RealmHelper.shared.realm.objects(User.self).filter("number == %@", number).isEmpty
    }
    
    func save() {
        RealmHelper.shared.save(object: self)
    }
}
