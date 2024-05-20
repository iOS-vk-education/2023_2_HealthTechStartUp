import XCTest
import VKID
@testable import Everyday

class MockVKIDAuthService: VKIDAuthServiceDescription {
    var vkid: VKID?
    var authWithVKIDResult: Result<Void, Error>?
    var loginWithVKIDResult: Result<Void, Error>?

    func authWithVKID(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = authWithVKIDResult {
            completion(result)
        }
    }

    func loginWithVKID(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = loginWithVKIDResult {
            completion(result)
        }
    }
}

class MockGoogleAuthService: GoogleAuthServiceDescription {
    var authed: Bool = false
    
    var authWithGoogleResult: Result<Void, Error>?
    var loginWithGoogleResult: Result<Void, Error>?

    func authWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = authWithGoogleResult {
            completion(result)
        }
    }

    func loginWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        if let result = loginWithGoogleResult {
            completion(result)
        }
    }
}

class MockFirebaseAuthService: FirebaseAuthServiceDescription {
    var registerUserResult: (Bool, Error?)?
    var forgotPasswordResult: (Bool, Error?)?
    var loginResult: (Bool, Error?)?
    var signOutResult: (Bool, Error?)?
    var userExistResult: (Bool, Error?)?

    func registerUser(with userRequest: ProfileAcknowledgementModel, completion: @escaping (Bool, Error?) -> Void) {
        if let result = registerUserResult {
            completion(result.0, result.1)
        }
    }

    func forgotPassword(with email: String, completion: @escaping (Bool, Error?) -> Void) {
        if let result = forgotPasswordResult {
            completion(result.0, result.1)
        }
    }

    func login(with data: Email, completion: @escaping (Bool, Error?) -> Void) {
        if let result = loginResult {
            completion(result.0, result.1)
        }
    }

    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        if let result = signOutResult {
            completion(result.0, result.1)
        }
    }

    func userExist(with email: String, completion: @escaping (Bool, Error?) -> Void) {
        if let result = userExistResult {
            completion(result.0, result.1)
        }
    }
}

final class AuthServiceTests: XCTestCase {
    var authService: AuthService!
    var mockVKIDAuthService: MockVKIDAuthService!
    var mockGoogleAuthService: MockGoogleAuthService!
    var mockFirebaseAuthService: MockFirebaseAuthService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockVKIDAuthService = MockVKIDAuthService()
        mockGoogleAuthService = MockGoogleAuthService()
        mockFirebaseAuthService = MockFirebaseAuthService()
        authService = AuthService(vkidAuthService: mockVKIDAuthService, googleAuthService: mockGoogleAuthService, firebaseAuthService: mockFirebaseAuthService)
    }
    
    override func tearDownWithError() throws {
        authService = nil
        mockVKIDAuthService = nil
        mockGoogleAuthService = nil
        mockFirebaseAuthService = nil
        try super.tearDownWithError()
    }
    
    func testAuthWithFirebaseSuccess() {
        let expectation = self.expectation(description: "authWithFirebase completion")
        mockFirebaseAuthService.registerUserResult = (true, nil)
        
        authService.authWithFirebase(with: ProfileAcknowledgementModel()) { result in
            if case .success = result {
                XCTAssertTrue(true)
            } else {
                XCTFail("Expected success but got \(result) instead")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testAuthWithFirebaseFailure() {
        let expectation = self.expectation(description: "authWithFirebase completion")
        let error = NSError(domain: "test", code: 1, userInfo: nil)
        mockFirebaseAuthService.registerUserResult = (false, error)
        
        authService.authWithFirebase(with: ProfileAcknowledgementModel()) { result in
            if case .failure(let err) = result {
                XCTAssertEqual(err as NSError, error)
            } else {
                XCTFail("Expected failure but got \(result) instead")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
