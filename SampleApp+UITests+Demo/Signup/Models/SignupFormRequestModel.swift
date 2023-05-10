//
//  SignupFormRequestModel.swift
//  TDD
//
//  Created by Daniyal Yousuf on 06/03/2023.
//

import Foundation

struct SignupFormRequestModel: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
