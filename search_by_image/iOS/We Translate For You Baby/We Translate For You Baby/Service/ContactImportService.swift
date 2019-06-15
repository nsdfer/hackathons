//
//  ContactImportService.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import Foundation
import Contacts
import PhoneNumberKit

class ContactImportService {
    static let shared = ContactImportService()
    
    let phoneNumberKit = PhoneNumberKit()
    let contactStore = CNContactStore()
    let keysToFetch: [CNKeyDescriptor] = [CNContactGivenNameKey as CNKeyDescriptor,
                                          CNContactFamilyNameKey as CNKeyDescriptor,
                                          CNContactPhoneNumbersKey as CNKeyDescriptor]
    
    func syncContacts(completion: () -> Void) {
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        do {
            try self.contactStore.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                guard let phoneNumber = contact.phoneNumbers.first else {
                    return
                }
                
                do {
                    let parsedNumber = try self.phoneNumberKit.parse(phoneNumber.value.stringValue)
                    let formattedNumber = self.phoneNumberKit.format(parsedNumber, toType: .e164)
                    guard User.hasContact(number: formattedNumber) == false else {
                        return
                    }
                    
                    let user = User(firstName: contact.givenName, lastName: contact.familyName, number: formattedNumber)
                    user.save()
                } catch {
                    print(error)
                }
                
            })
            
            completion()
        } catch {
            print(error)
            completion()
        }
    }
}
