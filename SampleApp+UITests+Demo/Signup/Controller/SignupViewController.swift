//
//  ViewController.swift
//  TDD
//
//  Created by Daniyal Yousuf on 05/03/2023.
//

import UIKit

final class SignupViewController: UIViewController {
    
    @IBOutlet weak private var firstNameTextField: UITextField!
    @IBOutlet weak private var lastNameTextField: UITextField!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var repeatpasswordTextField: UITextField!
    @IBOutlet weak private var signupButton: UIButton!
    
    private var signupPresenter: SignupPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let signupModelValidator = SignFormModelValidator()
        let webService = SignupWebService()
        signupPresenter = SignupPresenter(formModelValidator: signupModelValidator,
                                          webservice: webService,
                                          delegate: self)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapSignupButton(_ sender: Any) {
        let model = SignupFormModel(firstName: firstNameTextField.text ?? "",
                                    lastName: lastNameTextField.text ?? "",
                                    email: emailTextField.text ?? "",
                                    password: passwordTextField.text ?? "",
                                    repeatPassword: repeatpasswordTextField.text ?? "")
        
        signupPresenter?.processUserSignup(formModel: model)
    }
    
}

extension SignupViewController: SignupViewDelegateProtocol {
    func signup(result: Result<Void, SignupError>) {
        if case .success = result {
            successfullSignup()
        } else if case .failure(let error) = result {
            errorHandler(error: error)
        }
    }
   
    private func successfullSignup() {
        let alert = UIAlertController(title: "Successful",
                                      message: "Successfully Signed up", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async { [weak self] in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
            self?.present(vc, animated: true)
            
        }
    }
    
    private func errorHandler(error: SignupError) {
        let alert = UIAlertController(title: "Error",
                                      message: "Your request could not be processed at this time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert,
                         animated: true,
                         completion: nil)
        }
    }
}
