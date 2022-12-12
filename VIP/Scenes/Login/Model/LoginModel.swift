//
//  LoginModel.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

enum LoginModel {
    
    //MARK: Request

    struct Request {
        let username: String
        let password: String
    }
    
    //MARK: Response

    struct Response {
        let user: User
        let title: String
    }
    
    //MARK: ViewModel

    struct ViewModel {
        let fullTitle: String
    }
}
