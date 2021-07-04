//
//  DetailTests.swift
//  PokemonTests
//
//  Created by Jose Luis Tovar Jimenez on 2/07/21.
//

import XCTest
@testable import Pokemon

class DetailTests: XCTestCase {
    
    var sut: DetailViewController?

    override func setUpWithError() throws {
        sut = ViewControllerCatalog.Detail.createInstance() as? DetailViewController

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
