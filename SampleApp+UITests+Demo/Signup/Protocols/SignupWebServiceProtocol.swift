//
//  SignupWebServiceProtocol.swift
//  TDD
//
//  Created by Daniyal Yousuf on 06/03/2023.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withForm formModel: SignupFormRequestModel,
                completionHandler: @escaping (SignupFormResponseModel?, SignupError?) -> Void)
}
