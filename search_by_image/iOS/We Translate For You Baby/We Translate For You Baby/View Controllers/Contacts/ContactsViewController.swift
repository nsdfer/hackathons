//
//  ViewController2.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import UIKit
import MessageUI

class ContactsViewController: UIViewController {
    @IBOutlet weak var contactsView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsView.dataSource = self
        contactsView.delegate = self
        contactsView.rowHeight = UITableView.automaticDimension
        
        let contactsCellNib = UINib(nibName: "ContactTableViewCell", bundle: nil)
        contactsView.register(contactsCellNib, forCellReuseIdentifier: "ContactCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contactsView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkIfSignedIn()
    }
    
    @IBAction func addContact(_ sender: Any) {
//        let addContactNVC = ViewControllerModel.getNavigationController(for: .AddContact)
//        present(addContactNVC, animated: true, completion: nil)
        
        ContactImportService.shared.syncContacts {
            self.contactsView.reloadData()
        }
    }
    
    func checkIfSignedIn() {
        if Myself.isVerified() == false {
            let signInNVC = ViewControllerModel.getNavigationController(for: .SignIn)
            present(signInNVC, animated: true, completion: nil)
        }
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "Which language, baby?", message: "Choose One", preferredStyle: .actionSheet)
        
        let roomAction = UIAlertAction(title: "Chat", style: .default) { action in
            let chatVC = ChatViewController()
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
        
        actionSheet.addAction(roomAction)
        
        for language in LanguageType.allCases {
            let languageAction = UIAlertAction(title: language.title, style: .default, handler: { action in
                if (MFMessageComposeViewController.canSendText()) {
                    let user = User.allUsers[indexPath.row]
                    let controller = MFMessageComposeViewController()
                    controller.messageComposeDelegate = self
                    controller.body = "\(user.number);\(language.rawValue)\n\n"
                    controller.recipients = [Constants.backendNumber]
                    self.present(controller, animated: true, completion: nil)
                }
            })
            
            actionSheet.addAction(languageAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in }
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ContactTableViewCell else {
            return UITableViewCell()
        }
        
        let user = User.allUsers[indexPath.row]
        cell.setUp(with: user)
        
        return cell
    }
}

extension ContactsViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
