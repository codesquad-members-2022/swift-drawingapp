//
//  SceneDelegate.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let container: DIContainable = {
        let container = DIContainer()
        
        container.register(type: LayerContainable.self) {
            _ in PassivePlane.shared
        }

        container.register(type: LayerAddable.self) { _ in
            AddService(
                layerContainable: container.resolve(
                    type: LayerContainable.self
                )
            ) as AnyObject }

        container.register(type: LayerSelectable.self) { _ in
            SelectService(
                layerContainable: container.resolve(type: LayerContainable.self)
            ) as AnyObject }
        
        container.register(type: CanvasViewModel.self) { container in
            CanvasViewModel(
                layerAddable: container.resolve(
                    type: LayerAddable.self
                ),
                layerSelectable: container.resolve(
                    type: LayerSelectable.self
                )
            )
        }
        
        return container
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        guard let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as? DrawingSplitViewController else {
            fatalError("Unable to Instantiate Root View Controller")
        }
        
        rootViewController.container = container
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}

