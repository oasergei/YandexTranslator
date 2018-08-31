//
//  Model.swift
//  Translator
//
//  Created by Sergey on 22.08.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

struct Translate: Codable {
    let code: Int?
    let lang: String?
    let text: [String]?
}
