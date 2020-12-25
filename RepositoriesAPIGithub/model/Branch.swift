//
//  File.swift
//  RepositoriesAPIGithub
//
//  Created by Apple on 10/2/1942 Saka.
//

import Foundation
struct Branch: Codable  {
    var name: String?
    var protected: Bool
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case protected = "protected"
    }
}
