//
//  Repository.swift
//  RepositoriesAPIGithub
//
//  Created by Apple on 9/30/1942 Saka.
//

import Foundation
import UIKit
struct SearchRepo: Codable {
    let items: [Repository]?
}
struct Repository: Codable {
    var name: String
    var owners: Owner?
    enum CodingKeys:String, CodingKey {
        case name = "name"
        case owners = "owner"
    }
}
struct Owner: Codable  {
    var login: String?
    var avatar: String?
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatar = "avatar_url"
    }
}
