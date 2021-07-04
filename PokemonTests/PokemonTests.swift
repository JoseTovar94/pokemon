//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import XCTest
@testable import Pokemon

class PokemonTests: XCTestCase {

    var sut: HomeViewController?

    override func setUpWithError() throws {
        sut = ViewControllerCatalog.Home.createInstance() as? HomeViewController

        XCTAssertNotNil(sut, "No se encontró el ViewController en el Storyboard o no tiene asignada la clase correcta.")
        sut?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testHasATableView() {
        XCTAssertNotNil(sut?.tableView)
    }
    
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut?.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(((sut?.conforms(to: UITableViewDelegate.self)) != nil))
        XCTAssertTrue(((sut?.responds(to: #selector(sut?.tableView(_:didSelectRowAt:)))) != nil))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut?.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(((sut?.conforms(to: UITableViewDataSource.self)) != nil))
        XCTAssertTrue(((sut?.responds(to: #selector(sut?.tableView(_:numberOfRowsInSection:)))) != nil))
        XCTAssertTrue(((sut?.responds(to: #selector(sut?.tableView(_:cellForRowAt:)))) != nil))
    }

}
