//
//  MainViewController.swift
//  SwiftPractice
//
//  Created by Dinh Thanh An on 3/30/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation
import UIKit

import ReactiveCocoa
import ReactiveSwift
import Result

class MainViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username = MutableProperty("")
        
        usernameTextField.reactive.text <~ username        
    }
}
