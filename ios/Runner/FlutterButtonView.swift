//
//  File.swift
//  Runner
//
//  Created by Łukasz Matuszczak on 25/09/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import Flutter

class FlutterButtonViewFactory : NSObject, FlutterPlatformViewFactory {
    let binaryMessenger: FlutterBinaryMessenger
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        self.binaryMessenger = binaryMessenger
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FlutterButtonView(frame: frame, binaryMessenger: binaryMessenger)
    }
}

class FlutterButtonView: NSObject, FlutterPlatformView {
    private let frame: CGRect
    private let binaryMessenger: FlutterBinaryMessenger
    private let nativeViewMehodChannel: FlutterMethodChannel
    private var counter = 0
    
    lazy var floatingActionButton: UIButton = {
        let button = UIButton(frame: frame)
        button.setImage(#imageLiteral(resourceName: "floatingButton"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    init(frame: CGRect, binaryMessenger: FlutterBinaryMessenger) {
        self.frame = frame
        self.binaryMessenger = binaryMessenger
        nativeViewMehodChannel = FlutterMethodChannel(name: "appunite.flutter/showCounter",
                                                      binaryMessenger: binaryMessenger)
        
        super.init()
    }
    
    func view() -> UIView {
        return floatingActionButton
    }
    
    @objc func buttonAction(sender: UIButton!) {
        counter += 1
        nativeViewMehodChannel.invokeMethod("anyName", arguments: counter)
    }
}
