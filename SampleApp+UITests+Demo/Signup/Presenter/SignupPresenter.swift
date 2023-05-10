//
//  SignupPresenter.swift
//  TDD
//
//  Created by Daniyal Yousuf on 06/03/2023.
//

import Foundation


final class SignupPresenter: SignupPresenterProtocol {
    
    private var formModelValidator: SignupModelValidatorProtocol
    private var signupWebService: SignupWebServiceProtocol
    private weak var signupViewDelegate: SignupViewDelegateProtocol?
    
    required init(formModelValidator: SignupModelValidatorProtocol,
         webservice: SignupWebServiceProtocol,
         delegate: SignupViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.signupWebService = webservice
        self.signupViewDelegate = delegate
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
            signupViewDelegate?.signup(result: .failure(.validationError))  //this will cause the test to pass -
            return
        }
        
        if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
            //TODO: - pass the delegate in all the validations from here to bottom
            return 
        }
        
        if !formModelValidator.isValidEmailFormat(email: formModel.email) {
            return
        }
        
        if !formModelValidator.isPasswordValid(password: formModel.password) {
            return
        }
        
        if !formModelValidator.doPasswordsMatch(password: formModel.password,
                                                repeatPassword: formModel.repeatPassword) {
            return
        }
        
        let requestModel = SignupFormRequestModel(firstName: formModel.firstName,
                                                  lastName: formModel.lastName,
                                                  email: formModel.email,
                                                  password: formModel.password)
        
        signupWebService.signup(withForm: requestModel) { [weak self] model, error in
            if let _ = model {
                self?.signupViewDelegate?.signup(result: .success(Void()))
                return
            } else {
                self?.signupViewDelegate?.signup(result: .failure(SignupError.invalidResponseModel))
            }
        }
    }
}
