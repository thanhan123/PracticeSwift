//
//  InsertTodoViewController.swift
//  SwiftPractice
//
//  Created by Dinh Thanh An on 4/4/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation
import UIKit

import RealmSwift
import ReactiveCocoa
import ReactiveSwift

class InsertTodoViewController: UIViewController{
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Insert Item"
        
        detailTextView.layer.borderColor = UIColor.gray.cgColor
        detailTextView.layer.borderWidth = 1.0
        
        bindingUI()
    }
    
    func bindingUI() {
        self.addButton.isEnabled = false
        
        Signal.combineLatest(itemNameTextField.reactive.continuousTextValues, detailTextView.reactive.continuousTextValues)
        .observeValues{ itemNameString, itemDetailString in
            if (itemNameString?.characters.count)! > 0 && (itemDetailString?.characters.count)! > 0 {
                self.addButton.isEnabled = true
            } else {
                self.addButton.isEnabled = false
            }
        }
        
        addButton.reactive.controlEvents(.touchUpInside)
        .observe{ sender in
            let item = Item()
            item.itemDetail = self.detailTextView.text
            item.itemName = self.itemNameTextField.text!
            self.addObjectToRealm(item)
        }
    }
    
    func addObjectToRealm(_ object: Object) {
        try! self.realm.write {
            self.realm.add(object)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                [unowned self] in
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
