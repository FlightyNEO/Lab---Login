//
//  ProfileViewController.swift
//  Lab - Login
//
//  Created by Arkadiy Grigoryanc on 04/03/2019.
//  Copyright © 2019 Arkadiy Grigoryanc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    var name: String?
    var eMail: String?
    var password: String?
    
    // MARK: - Outlets
    @IBOutlet weak var eMailLabel: UILabel! {
        didSet { self.eMailLabel.text = eMail }
    }
    @IBOutlet weak var passwordLabel: UILabel! {
        didSet { self.passwordLabel.text = password }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet { self.nameLabel.text = name }
    }
    
    // MARK: - Life cicles
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

// MARK: - Navigation
extension ProfileViewController {
    
    
    
}
