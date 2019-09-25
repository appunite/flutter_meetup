//
//  NativeViewController.swift
//  Runner
//
//  Created by Łukasz Matuszczak on 25/09/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Foundation

class NativeViewController: UIViewController {
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    private var counter = 0
    
    @IBAction func incrementAction(_ sender: Any) {
        counter += 1
        counterLabel.text = "\(counter)"
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
}
