//
//  ReactViewController.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import UIKit
import React
import React_RCTAppDelegate
import ReactAppDependencyProvider

class ReactViewController: UIViewController {
    var reactNativeFactory: RCTReactNativeFactory?
    var reactNativeFactoryDelegate: RCTReactNativeFactoryDelegate?
    
    var stock: Stock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactNativeFactoryDelegate = ReactNativeDelegate()
        reactNativeFactoryDelegate!.dependencyProvider = RCTAppDependencyProvider()
        reactNativeFactory = RCTReactNativeFactory(delegate: reactNativeFactoryDelegate!)
        let props: [AnyHashable: Any] = [
            "data": stock?.lastSevenDays() ?? [:],
            "ticker": stock?.ticker ?? ""
        ]
        view = reactNativeFactory!.rootViewFactory.view(
            withModuleName: "SUIRN",
            initialProperties: props
        )
  }
}

class ReactNativeDelegate: RCTDefaultReactNativeFactoryDelegate {
    override func sourceURL(for bridge: RCTBridge) -> URL? {
        self.bundleURL()
    }
    
    override func bundleURL() -> URL? {
#if DEBUG
        RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
#else
        Bundle.main.url(forResource: "main", withExtension: "jsbundle")
#endif
    }
}
