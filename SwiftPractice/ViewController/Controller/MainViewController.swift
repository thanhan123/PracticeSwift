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
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Login"
        
        bindingUI()
    }
    
    func bindingUI() {
        // binding UI 2 way
        usernameTextField.reactive.text <~ viewModel.usernameString.producer
        viewModel.usernameString <~ usernameTextField.reactive.continuousTextValues.map { $0! }
        
        passwordTextField.reactive.text <~ viewModel.passwordString.producer
        viewModel.passwordString <~ passwordTextField.reactive.continuousTextValues.map { $0! }
        
        // combine property
        let checkValidProperty = Property.combineLatest(viewModel.usernameString, viewModel.passwordString)
        button.reactive.backgroundColor <~ checkValidProperty.map{ usrn, pass in
            return (usrn.characters.count) > 2 && (pass.characters.count) > 2 ? UIColor.green : UIColor.clear
        }
        button.reactive.isEnabled <~ checkValidProperty.map{ usrn, pass in
            return (usrn.characters.count) > 2 && (pass.characters.count) > 2
        }
        
//        button.reactive.controlEvents(.touchUpInside)
//        .observeValues{ sender in
//            if self.usernameTextField.text == "dinhthanhan" && self.passwordTextField.text == "123456" {
//                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//                let listTodoItemVC = storyBoard.instantiateViewController(withIdentifier: "ListTodoViewController") as! ListTodoViewController
//                self.navigationController?.pushViewController(listTodoItemVC, animated: true)
//            }
//        }
        
//        button.reactive.pressed = CocoaAction(viewModel.loginAction!)
    }
}

class MainViewModel {
    let usernameString = MutableProperty("")
    let passwordString = MutableProperty("")
//    let loginAction: Action<Void, Void, NoError>?
//    let checkValidProperty: Property<(String, String)>?
    
    init() {
//        loginAction = Action(enabledIf: { 1 > 0 }, { (<#Input#>) -> SignalProducer<_, _> in
//            <#code#>
//        })
    }
}
