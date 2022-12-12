//
//  swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import XCTest

class LoginWorkTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: LoginWorker!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    // MARK: - Test Mock
    
    class LoginServiceSpy: LoginService {
        
        // MARK: Method call expectations
        
        var loginCalled = false
        
        // MARK: Argument expectations

        var testUserFirstName: String = Seeds.UserLogin.userApollo11.firstName
        var testUserLastName: String = Seeds.UserLogin.userApollo11.lastName
        var testUserGenre: String = Seeds.UserLogin.userApollo11.genre
        
        // MARK: Spied methods
        
        func login(username: String, password: String, success: @escaping (String, String, String) -> (), fail: @escaping (String) -> ()) {
            loginCalled = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                if username.isEmpty, password.isEmpty {
                    fail("login error empty")
                } else {
                    success(self.testUserFirstName, self.testUserLastName, self.testUserGenre)
                }
            }
        }
    }
    
    // MARK: - Tests
    
    func testLoginWorkerShouldReturnUser() {
        // Given
        let serviceSpy = LoginServiceSpy()
        sut = LoginWorker(serviceSpy)
        
        // When
        var loggedUser: User!
        let expect = expectation(description: "Wait for login to return")
        
        sut.login(username: "user", password: "password", success: { (user) in
            loggedUser = user
            expect.fulfill()
        }, fail: { (response) in
            
        })
        waitForExpectations(timeout: 1.1)
        
        //Then
        XCTAssertEqual(loggedUser.firstName, "Margaret", "user logged firstName should be Margaret")
        XCTAssertEqual(loggedUser.lastName, "Hamilton", "user logged lastName should be Hamilton")
        XCTAssertEqual(loggedUser.genre, "feminino", "user logged genre should be feminino")
        
        
    }
    
    func testLoginWorkerFail() {
        // Given
        let serviceSpy = LoginServiceSpy()
        serviceSpy.testUserFirstName = Seeds.UserLogin.userApollo11.firstName
        serviceSpy.testUserLastName = Seeds.UserLogin.userApollo11.lastName
        serviceSpy.testUserGenre = Seeds.UserLogin.userApollo11.genre
        
        sut = LoginWorker(serviceSpy)
        
        // When
        var loginError: String!
        let expect = expectation(description: "Wait for login to return")
        
        sut.login(username: "", password: "", success: { (user) in
            
        }, fail: { (message) in
            loginError = message
            expect.fulfill()
        })
        waitForExpectations(timeout: 1.1)
        
        //Then
        XCTAssertEqual(loginError, "login error empty", "error message should be 'login error empty'")
        
    }
}
