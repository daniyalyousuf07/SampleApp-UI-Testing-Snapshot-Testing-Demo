//
//  SignupPresenterProtocol.swift
//  TDD
//
//  Created by Daniyal Yousuf on 07/03/2023.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    init(formModelValidator: SignupModelValidatorProtocol,
         webservice: SignupWebServiceProtocol,
         delegate: SignupViewDelegateProtocol)
    func processUserSignup(formModel: SignupFormModel)
}
