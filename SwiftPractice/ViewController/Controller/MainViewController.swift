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
        
        button.reactive.backgroundColor <~ Signal.combineLatest(usernameSignal, passwordSignal).map({ usrn, pass in
            return (usrn?.characters.count)! > 2 && (pass?.characters.count)! > 2 ? UIColor.green : UIColor.clear
        })
        
        button.reactive.controlEvents(.touchUpInside)
        .observeValues{ sender in
            if self.usernameTextField.text == "dinhthanhan" && self.passwordTextField.text == "123456" {
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let listTodoItemVC = storyBoard.instantiateViewController(withIdentifier: "ListTodoViewController") as! ListTodoViewController
                self.navigationController?.pushViewController(listTodoItemVC, animated: true)
            }
        }
    }
}
