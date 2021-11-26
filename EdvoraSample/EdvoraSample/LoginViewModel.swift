//
//  LoginViewModel.swift
//  EdvoraSample
//
//  Created by Ummer.Manjeri on 25/11/21.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email = "umerfaruk.m@gmail.com"
    @Published var password = "abcdefG1"
    @Published var username = "ummer.manjeri"
    
    @Published var isEmailCriteriaValid = false
    @Published var isPasswordCriteriaValid = false
    @Published var isUsernameCriteriaValid = false
    @Published var canSubmit = false
    private var cancellableSet: Set<AnyCancellable> = []
    
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")
    let usernamePredicate = NSPredicate(format: "SELF MATCHES %@ ", "[a-za-z0-9!@#$%^&*()._-]{1,16}")
    
    init() {
        
        $username
            .map { username in
                return self.usernamePredicate.evaluate(with: username)
            }
            .assign(to: \.isUsernameCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .map { password in
                return self.passwordPredicate.evaluate(with: password)
            }
            .assign(to: \.isPasswordCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        $email
            .map { email in
                return self.emailPredicate.evaluate(with: email)
            }
            .assign(to: \.isEmailCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        
        Publishers.CombineLatest3($isUsernameCriteriaValid, $isPasswordCriteriaValid, $isEmailCriteriaValid)
            .map { isUsernameCriteriaValid, isPasswordCriteriaValid, isEmailCriteriaValid in
                return (isUsernameCriteriaValid && isPasswordCriteriaValid && isEmailCriteriaValid)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
    }
    
    
    var usernamePrompt: String {
        isUsernameCriteriaValid ?
        ""
        :
        "Should not have spaces and no upper case alphabet."
    }
    
    var emailPrompt: String {
        isEmailCriteriaValid ?
        ""
        :
        "Enter a valid email address"
    }
    
    var passwordPrompt: String {
        isPasswordCriteriaValid ?
        ""
        :
        "Should have 8 charecters, 1 number, 1 upper case alphabet, 1 lowercase alphabet."
    }
    
    
    
    func login() {
        username = ""
        password = ""
        email = ""
    }
}



