//
//  FlutterCounterView.swift
//  Runner
//
//  Created by Łukasz Matuszczak on 25/09/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation
import Flutter

class FlutterCounterViewFactory : NSObject, FlutterPlatformViewFactory {
    let binaryMessenger: FlutterBinaryMessenger
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        self.binaryMessenger = binaryMessenger
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return FlutterCounterView(frame: frame, binaryMessenger: binaryMessenger)
    }
}

class FlutterCounterView: NSObject, FlutterPlatformView {
    static let title = "You have pushed the button this many times:"
    
    private let frame: CGRect
    private  let binaryMessenger: FlutterBinaryMessenger
    lazy var label = UILabel(frame: frame)
    
    init(frame: CGRect, binaryMessenger: FlutterBinaryMessenger) {
        self.frame = frame
        self.binaryMessenger = binaryMessenger
        
        let nativeViewMehodChannel = FlutterMethodChannel(name: "appunite.flutter/incrementCounter",
                                                          binaryMessenger: binaryMessenger)
        
        super.init()
        
        nativeViewMehodChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard call.method == "incrementCounter" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            guard let wSelf = self,
                let arg = call.arguments,
                let count = arg as? Int
                else {
                    result(FlutterError(code: "500", message: nil, details: nil))
                    return
            }
            
            DispatchQueue.main.async {
                wSelf.updateTitle(counter: count)
            }
        })
    }
    
    func view() -> UIView {
        updateTitle(counter: 0)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
    
    private func updateTitle(counter: Int) {
        let quote = "\(FlutterCounterView.title)\n\(counter)"
        let attributedQuote = NSMutableAttributedString(string: quote)
        attributedQuote.addAttribute(.font, value: UIFont.systemFont(ofSize: 22), range: NSRange(location: FlutterCounterView.title.count+1, length: String(counter).count))
        label.attributedText = attributedQuote
    }
}
