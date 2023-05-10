//
//  SignupError.swift
//  TDD
//
//  Created by Daniyal Yousuf on 06/03/2023.
//

import Foundation

enum SignupError: LocalizedError, Equatable {
    //LocalizedError Protocol can help updating localizedDescription key of Error object
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    case illegalCharacter
    case validationError
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let desc):
            return desc
        case .invalidResponseModel, .invalidRequestURLString:
            return ""
        default:
            return ""
        }
    }
}
