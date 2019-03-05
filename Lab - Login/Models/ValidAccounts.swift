//
//  ValidAccounts.swift
//  Lab - Login
//
//  Created by Arkadiy Grigoryanc on 04/03/2019.
//  Copyright © 2019 Arkadiy Grigoryanc. All rights reserved.
//

import Foundation

let FakePersons = [
    Person(name: "Pavel", eMail: "pavel@mail.ru", password: "111"),
    Person(name: "Sacha", eMail: "sasha@mail.ru", password: "222"),
    Person(name: "Masha", eMail: "masha@mail.ru", password: "333")
]

struct Person: CustomStringConvertible {
    let name: String
    let eMail: String
    let password: String
    
    var description: String {
        return "\(eMail) - \(password)\t\t"
    }
    
}
