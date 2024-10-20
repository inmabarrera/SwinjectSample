//
//  BaseTest.swift
//  SwinjectSampleTests
//
//  Created by Inma on 20/10/24.
//

import XCTest
@testable import SwinjectSample

class BaseTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        DIContainerProvider.shared = TestsDIContainer.shared
    }
}
