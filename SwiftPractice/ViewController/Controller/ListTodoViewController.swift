//
//  ListTodoViewController.swift
//  SwiftPractice
//
//  Created by Dinh Thanh An on 4/10/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation
import UIKit

import ReactiveCocoa
import ReactiveSwift
import Result
import RealmSwift

class ListTodoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var todoItemTableView: UITableView!
    
    var listTodoItem: Results<Item>?
    let realm: Realm = try! Realm()
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Todo List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.done, target: self, action: #selector(rightButtonTapped))
        
        todoItemTableView.delegate = self
        todoItemTableView.dataSource = self
        
        setupUI()
        setupData()
        bindingUI()
    }
    
    deinit {
        token?.stop()
    }
    
    // private func
    func setupData() {
        listTodoItem = realm.objects(Item.self);
        todoItemTableView.reloadData()
    }
    
    func setupUI() {
        todoItemTableView.rowHeight = UITableViewAutomaticDimension
        todoItemTableView.estimatedRowHeight = 100
        todoItemTableView.tableFooterView = UIView()
    }
    
    func bindingUI() {
        token = realm.addNotificationBlock { notification, realm in
            self.setupData()
        }
    }
    
    func rightButtonTapped() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let insertTodoVC = storyBoard.instantiateViewController(withIdentifier: "InsertTodoViewController") as! InsertTodoViewController
        self.navigationController?.pushViewController(insertTodoVC, animated: true)
    }
    
    // tableview delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listTodoItem?.elements.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath) as! TodoItemCell
        
        let data = listTodoItem?.elements[indexPath.row]
        cell.itemNameLabel.text = data?.itemName;
        cell.itemDetailLabel.text = data?.itemDetail
        
        return cell
    }
}
