//
//  LoginViewControllerTest.swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import XCTest

class LoginViewControllerTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: LoginViewController!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = LoginViewController.loadFromNib()
        sut.viewDidLoad()
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(sut!.view)

    }
    
    override func tearDown() {
        super.tearDown()
        
    }

    // MARK: - Test doubles
    
    class LoginInteractorSpy: LoginInteractor {
        
        // MARK: Method call expectations
        
        var loginCalled = false
        
        // MARK: Spied methods
        
        func login(_ request: LoginModel.Request) {
            loginCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testLogin() {
        sut = LoginViewController.loadFromNib()
        sut.interactor = LoginInteractorSpy()
        
        //There is nothing on the login screen in this simple example app
    }
    
}
