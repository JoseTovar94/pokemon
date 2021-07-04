//
//  TestConfigUI.swift
//  PokemonUITests
//
//  Created by Jose Luis Tovar Jimenez on 2/07/21.
//
import Foundation
import XCTest

class TestConfigUI: XCTestCase {

    var app : XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchEnvironment.updateValue("YES", forKey: "UITesting")
        app.launchArguments = ["--Reset"]
        
        configureMockedServer()
        
        app.launch()
    }
    
    override func tearDownWithError() throws {
        self.app = nil
        try super.tearDownWithError()
    }
    
    func configureMockedServer() {
        MockedAPI.startServer()
    }
    
    func addSuccess(_ endpoint: String, jsonFile: MockedJSONSuccess) {
        MockedAPI.addSuccess(endpoint, jsonFile: jsonFile)
    }
    
    func addError(_ endpoint: String, jsonFile: MockedJSONError) {
        MockedAPI.addError(endpoint, jsonFile: jsonFile)
    }
}
extension XCTestCase {
    func attachScreenshot(name: String) {
        let mainScreenScreenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: mainScreenScreenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func waitForElementToAppear(element: XCUIElement, timeout: TimeInterval = 15,  file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate,
                    evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.record(.init(type: .assertionFailure, compactDescription: message))
            }
        }
    }
    
    func waitForElementToDisappear(element: XCUIElement, timeout: TimeInterval = 15,  file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == false")
        
        expectation(for: existsPredicate,
                    evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to remove \(element) after \(timeout) seconds."
                self.record(.init(type: .assertionFailure, compactDescription: message))
            }
        }
    }
    
    func waitForUITransition() {
        sleep(1)
    }
}
