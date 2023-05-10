//
//  SignupViewDelegateProtocol.swift
//  TDD
//
//  Created by Daniyal Yousuf on 06/03/2023.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    func signup(result: Result<Void, SignupError>)
}
