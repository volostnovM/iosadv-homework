//
//  MapCoordinator.swift
//  Navigation
//
//  Created by TIS Developer on 16.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit


class MapCoordinator: CoordinatorProtocol {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [CoordinatorProtocol]()
    let navigationController: UINavigationController
    
    required init() {
        self.navigationController = .init()
    }
    
    func openLikeViewController() {
        let mapViewController: MapViewController = MapViewController()
        self.navigationController.pushViewController(mapViewController, animated: true)
    }
}

