//
//  ContactTableViewCell.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstName.text = nil
        lastName.text = nil
        phoneNumber.text = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        firstName.text = nil
        lastName.text = nil
        phoneNumber.text = nil
    }
    
    func setUp(with user: User) {
        firstName.text = user.firstName
        lastName.text = user.lastName
        phoneNumber.text = user.number
    }
}
