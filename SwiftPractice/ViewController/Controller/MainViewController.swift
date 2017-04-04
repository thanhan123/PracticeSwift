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
        
        let usernameSignal = usernameTextField.reactive.continuousTextValues
        let passwordSignal = passwordTextField.reactive.continuousTextValues
        
        let usernameValue = MutableProperty("")
        let passwordValue = MutableProperty("")
        
        Signal.combineLatest(usernameSignal, passwordSignal)
        .filter{ username, password -> Bool in
            if username!.characters.count > 2 && password!.characters.count > 2 {
                self.button.backgroundColor = UIColor.green
                return true
            } else {
                self.button.backgroundColor = UIColor.clear
                return false
            }
        }
        .observeValues{username, password in
            usernameValue.value = username!
            passwordValue.value = password!
        }
        
        button.reactive.controlEvents(.touchUpInside)
        .observeValues{ sender in
            if usernameValue.value == "dinhthanhan" && passwordValue.value == "123456" {
                
            }
        }
    }
}
