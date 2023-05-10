//
//  SignupWebService.swift
//  SampleApp+UITests+Demo
//
//  Created by Daniyal Yousuf on 2023-05-09.
//

import Foundation

class SignupWebService: SignupWebServiceProtocol {
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupFormResponseModel?, SignupError?) -> Void) {
        completionHandler(.init(status: "success"), nil)
    }
}
