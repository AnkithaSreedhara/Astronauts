//
//  CustomErrors.swift
//  Astronaut
//
//  Created by Anki on 23/03/21.
//

import Foundation
struct CustomError {

    var title: String?
    var code: Int?
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code 
    }
}
