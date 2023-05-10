//
//  SignupFlowUITests.swift
//  SampleApp+UITests+DemoUITests
//
//  Created by Daniyal Yousuf on 2023-05-09.
//

import XCTest

final class SignupFlowUITests: XCTestCase {
    
    private  var app: XCUIApplication!
    private var firstNameTextField: XCUIElement!
    private var lastNameTextField: XCUIElement!
    private var emailTextField: XCUIElement!
    private var passwordTextField: XCUIElement!
    private var repeatPasswordTextField: XCUIElement!
    private var signupButton: XCUIElement!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        firstNameTextField = app.textFields["firstNameTextField"]
        lastNameTextField = app.textFields["lastNameTextField"]
        emailTextField = app.textFields["emailTextField"]
        passwordTextField = app.textFields["passTextField"]
        repeatPasswordTextField = app.textFields["repeatpasswordTextField"]
        signupButton = app.buttons["signupButton"]
        
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app = nil
        firstNameTextField = nil
        lastNameTextField = nil
        emailTextField = nil
        passwordTextField = nil
        repeatPasswordTextField = nil
        signupButton = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSignupViewController_RequiredUIElementsAreEnabledAsViewLoaded() throws {
        // UI tests must launch the application that they test.
        //Literals are based on accessibility ids.
        XCTAssertTrue(firstNameTextField.isEnabled, "FirstNameTextField is not enabled for user interaction")
        XCTAssertTrue(lastNameTextField.isEnabled, "LastNameTextField is not enabled for user interaction")
        XCTAssertTrue(emailTextField.isEnabled, "FatherNameTextField is not enabled for user interaction")
        //Write all other test cases here...
        
    }
    
    func testSignupViewController_PresentErrorAlertDialog_AsUserSubmitsInvalidForm() {
        //Literals are based on accessibility ids.
        firstNameTextField.tap()
        firstNameTextField.typeText("d")
        
        
        lastNameTextField.tap()
        lastNameTextField.typeText("Yousuf")
        
        emailTextField.tap()
        emailTextField.typeText("daniyal@gmail.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        
        repeatPasswordTextField.tap()
        repeatPasswordTextField.typeText("1234")
        
        signupButton.tap()
        
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1),
                      "An error alertdialog was not presented on invalid form submission")
    }
    
    func testSignupViewController_PresentWelcomeScreen_AsUserSubmitsValidForm() {
        //Literals are based on accessibility ids.
        firstNameTextField.tap()
        firstNameTextField.typeText("daniyal")
        
        
        lastNameTextField.tap()
        lastNameTextField.typeText("Yousuf")
        
        emailTextField.tap()
        emailTextField.typeText("daniyal@gmail.com")
        
        passwordTextField.tap()
        passwordTextField.typeText("123456789")
        
        repeatPasswordTextField.tap()
        repeatPasswordTextField.typeText("123456789")
        
        //MARK: - SNAPSHOT TESTING
        let attachment = app.getAttachment(name: "Signup Screenshot",
                                           lifeTime: .keepAlways)
        add(attachment)
        
        signupButton.tap()
        
        XCTAssertTrue(app.otherElements["homeVC"].waitForExistence(timeout: 1),
                      "Welcome Screen was not presented on valid form submission")
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

//MARK: - SNAPSHOT TESTING
extension XCUIElement {
    func getAttachment(name: String,
                       lifeTime: XCTAttachment.Lifetime = .deleteOnSuccess) -> XCTAttachment {
         let currentAppWindow = screenshot()
         let currentAppWindowAttachment = XCTAttachment(screenshot: currentAppWindow)
         currentAppWindowAttachment.name = name
         currentAppWindowAttachment.lifetime = lifeTime
        return currentAppWindowAttachment
    }
}
