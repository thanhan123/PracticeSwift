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
        
        Signal.combineLatest(usernameSignal, passwordSignal)
            .observeValues{aString, bString in
                if aString!.characters.count > 2 && bString!.characters.count > 2 {
                    self.button.backgroundColor = UIColor.green
                } else {
                    self.button.backgroundColor = UIColor.clear
                }
                print("username: \(aString!) - password: \(bString!)")
        }
        
//        let a = MutableProperty<String>("")
//        let b = MutableProperty<String>("")
        
//        usernameTextField.reactive.text <~ a
//        passwordTextField.reactive.text <~ b
    }
}
