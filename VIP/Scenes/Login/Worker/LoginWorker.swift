//
//  LoginWork.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

protocol LoginWorkerProtocol: AnyObject {
    func login(username: String, password:String, success: @escaping(_ response: User) -> Void, fail:@escaping(_ message: String) -> Void)
}

class LoginWorker {

    // MARK: - Private Properties

    private var service: LoginService
    
    // MARK: - Init

    init(_ service: LoginService = LoginServiceImplementation()) {
        self.service = service
    }
}

//MARK: LoginWorkerProtocol

extension LoginWorker: LoginWorkerProtocol {
    func login(username: String, password: String, success: @escaping (User) -> Void, fail: @escaping (String) -> Void) {
        service.login(username: username, password: password) { (firstName, lastName, genre)  in
            
            let user = User(firstName: firstName, lastName: lastName, genre: genre)
            
            success(user)
            
        } fail: { (message) in
            fail(message)
        }
    }
}
