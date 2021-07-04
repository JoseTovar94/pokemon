//
//  PokemonUITests.swift
//  PokemonUITests
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import XCTest
@testable import Pokemon

class PokemonUITests: TestConfigUI {

    
    func testHomeSuccess() throws {
        addSuccess(Constants.Request.home, jsonFile: MockedJSONSuccess.home)
        let articleTableView = app.tables["table--Home"]
     
        XCTAssertTrue(articleTableView.exists, "The tableview exists")
    }
}
