//
//  LoginInteractorTest.swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import XCTest

class LoginInteractorTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: LoginInteractorImplementation!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Mock
    
    class LoginPresenterSpy: LoginPresenter {
        
        // MARK: Method call expectations
        
        var presentLoginCalled = false

        // MARK: Argument expectations

        var responseTest: LoginModel.Response!
        var errorMessageTest: String!
        
        // MARK: LoginPresenter methods
        
        func interactor(didSuccessLogin response: LoginModel.Response) {
            responseTest = response
            presentLoginCalled = true
        }
        
        func interactor(didFailLogin error: String) {
            presentLoginCalled = true
            errorMessageTest = error
        }
    }
    
    class LoginWorkerSpy: LoginWorkerProtocol {
        
        // MARK: Method call expectations
        
        var loginWorkerCalled = false
        
        // MARK: Spied methods
        
        func login(username: String, password: String, success: @escaping (User) -> Void, fail: @escaping (String) -> Void) {
            loginWorkerCalled = true
            if username.isEmpty, password.isEmpty {
                fail("login error empty")
            } else {
                success(username == "Margaret" ? Seeds.UserLogin.userApollo11 : Seeds.UserLogin.userUncleBob)
            }
        }
    }
  
    // MARK: - Test login
    
    func testLoginSuccessWithMaleUser() {
        // Given
        let loginPresenterSpy = LoginPresenterSpy()
        let loginWorkerSpy = LoginWorkerSpy()

        sut = LoginInteractorImplementation(loginPresenterSpy, loginWorkerSpy)
        
        // When
        let request = LoginModel.Request.init(username: "Robert", password: "Password")
        sut.login(request)
        
        // Then
        let response = loginPresenterSpy.responseTest
        
        XCTAssert(loginWorkerSpy.loginWorkerCalled, "Login() should be called")
        XCTAssert(loginPresenterSpy.presentLoginCalled, "Login() should ask presenter to login")
        XCTAssertEqual(response?.title, "Mr", "user response title should be Mr")
        XCTAssertEqual(response?.user.firstName, "Robert", "user response firstName should be Robert")
        XCTAssertEqual(response?.user.lastName, "Martin", "user response lastName should be Martin")
        XCTAssertEqual(response?.user.genre, "masculino", "user response genre should be masculino")
    }
    
    func testLoginSuccessWithFemaleUser() {
        // Given
        let loginPresenterSpy = LoginPresenterSpy()
        let loginWorkerSpy = LoginWorkerSpy()

        sut = LoginInteractorImplementation(loginPresenterSpy, loginWorkerSpy)
        
        // When
        let request = LoginModel.Request.init(username: "Margaret", password: "Password")
        sut.login(request)
        
        // Then
        let response = loginPresenterSpy.responseTest
        
        XCTAssert(loginWorkerSpy.loginWorkerCalled, "Login() should be called")
        XCTAssert(loginPresenterSpy.presentLoginCalled, "Login() should ask presenter to login")
        XCTAssertEqual(response?.title, "Mrs", "user response title should be Mr")
        XCTAssertEqual(response?.user.firstName, "Margaret", "user response firstName should be Margaret")
        XCTAssertEqual(response?.user.lastName, "Hamilton", "user response lastName should be Hamilton")
        XCTAssertEqual(response?.user.genre, "feminino", "user response genre should be feminino")
    }
    
    func testLoginFail() {
        // Given
        let loginPresenterSpy = LoginPresenterSpy()
        let loginWorkerSpy = LoginWorkerSpy()

        sut = LoginInteractorImplementation(loginPresenterSpy, loginWorkerSpy)
        
        // When
        let request = LoginModel.Request.init(username: "", password: "")
        sut.login(request)
        
        // Then
        XCTAssert(loginWorkerSpy.loginWorkerCalled, "Login() should be called")
        XCTAssert(loginPresenterSpy.presentLoginCalled, "Login() should ask presenter to login")
        XCTAssertEqual(loginPresenterSpy.errorMessageTest, "login error empty", "user response title should be 'login error empty'")
        XCTAssertNil(loginPresenterSpy.responseTest, "Response should be nil in login fail")
    }
    
}
