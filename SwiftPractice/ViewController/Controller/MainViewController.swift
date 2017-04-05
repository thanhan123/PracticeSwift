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
        self.navigationItem.title = "Login"
        
        bindingUI()
    }
    
    func bindingUI() {
        let usernameSignal = usernameTextField.reactive.continuousTextValues
        let passwordSignal = passwordTextField.reactive.continuousTextValues
        
        var usernameString = ""
        var passwordString = ""
        
        Signal.combineLatest(usernameSignal, passwordSignal)
            .throttle(0.5, on: QueueScheduler.main)
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
                usernameString = username!
                passwordString = password!
        }
        
        button.reactive.controlEvents(.touchUpInside)
        .observeValues{ sender in            
            if usernameString == "dinhthanhan" && passwordString == "123456" {
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let insertTodoVC = storyBoard.instantiateViewController(withIdentifier: "InsertTodoViewController") as! InsertTodoViewController
                self.navigationController?.pushViewController(insertTodoVC, animated: true)
            }
        }
    }
}
