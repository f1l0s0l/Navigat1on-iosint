//
//  MainCoordinatorTests.swift
//  Navigat1onTests
//
//  Created by Илья Сидорик on 30.05.2023.
//

import XCTest
@testable import Navigat1on

class MainCoordinatorTests: XCTestCase {

    var rootViewController: UIViewController!
    var sut: MainCoordinator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.rootViewController = UIViewController()
        self.sut = MainCoordinator(rootViewController: self.rootViewController)
    }

    override func tearDownWithError() throws {
        self.rootViewController = nil
        self.sut = nil
        try super.tearDownWithError()
    }

    
    func testStartOpenLoginViewController() throws {
        // GIVEN
        
        // WHEN
        let _ = self.sut.start()
        
        
        // THEN
        let currentViewController = (self.rootViewController.children.last as? UINavigationController)?.viewControllers.last
        XCTAssertTrue(currentViewController is LogInViewController2)
    }

    
    func testSwitchToTabBarController() throws {
        // GIVEN
        let user = User(
            fullName: "UnitTestUser",
            avatar: nil,
            status: "UnitTestStatus"
        )
        
        
        // WHEN
        let _ = self.sut.start()
        self.sut.switchToTabBarController(user: user)
        
        
        // THEN
        XCTAssertTrue(self.rootViewController.children.last is UITabBarController)
    }
    
    
    func testSwitchToTabBarControllerWhithCerrentViewControllers() throws {
        // GIVEN
        let user = User(
            fullName: "UnitTestUser",
            avatar: nil,
            status: "UnitTestStatus"
        )
        
        // WHEN
        let _ = self.sut.start()
        self.sut.switchToTabBarController(user: user)
        
        
        // THEN
        let currentFeedViewController = ((self.rootViewController.children.last as? UITabBarController)?.viewControllers?[0] as? UINavigationController)?.viewControllers.last
        let currentMapViewController = ((self.rootViewController.children.last as? UITabBarController)?.viewControllers?[1] as? UINavigationController)?.viewControllers.last
        let currentFavouritesViewController = ((self.rootViewController.children.last as? UITabBarController)?.viewControllers?[2] as? UINavigationController)?.viewControllers.last
        let currentProfileViewController = ((self.rootViewController.children.last as? UITabBarController)?.viewControllers?[3] as? UINavigationController)?.viewControllers.last

        XCTAssertTrue(currentFeedViewController is FeedViewController2)
        XCTAssertTrue(currentMapViewController is MapViewController)
        XCTAssertTrue(currentFavouritesViewController is FavouritesViewController)
        XCTAssertTrue(currentProfileViewController is ProfileViewController)
    }
    
}
