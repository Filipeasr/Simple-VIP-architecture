//
//  LoginPresenterTest.swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import XCTest

class LoginPresenterTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: LoginPresenterImplementation!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Mock
    
    class ViewControllerSpy: LoginPresenterOutput {
        
        // MARK: Method call expectations
        
        var displayLoginCalled = false

        // MARK: Argument expectations
        
        var viewModel: LoginModel.ViewModel?
        var errorMessage: String?
        
        // MARK: Spied methods
        
        func presenter(didSuccessLogin viewModel: LoginModel.ViewModel) {
            displayLoginCalled = true
            self.viewModel = viewModel
        }
        
        func presenter(didFailLogin message: String) {
            displayLoginCalled = true
            self.errorMessage = message
        }
    }
    
    func testPresentSuccessLogin() {
        //Given
        let viewControllerSpy = ViewControllerSpy()
        sut = LoginPresenterImplementation(viewControllerSpy)

        //When
        let user = Seeds.UserLogin.userApollo11
        let response = LoginModel.Response(user: user, title: "Mrs")
        
        sut.interactor(didSuccessLogin: response)
        
        //Then
        let loggedViewModel = viewControllerSpy.viewModel
        XCTAssertEqual(loggedViewModel?.fullTitle, "Mrs Margaret Hamilton", "logged in full name should be Margaret Hamilton")
        
    }
    
    func testPresentFailLogin() {
        //Given
        let viewControllerSpy = ViewControllerSpy()
        sut = LoginPresenterImplementation(viewControllerSpy)

        //When
        sut.interactor(didFailLogin: "Fail present login")
        
        //Then
        let errorMessageLogin = viewControllerSpy.errorMessage
        XCTAssertEqual(errorMessageLogin, "Fail present login", "logged error message should be Fail present login'")
    }
}
