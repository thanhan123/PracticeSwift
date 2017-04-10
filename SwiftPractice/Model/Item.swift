//
//  Item.swift
//  SwiftPractice
//
//  Created by Dinh Thanh An on 4/10/17.
//  Copyright © 2017 Dinh Thanh An. All rights reserved.
//

import Foundation

import RealmSwift

class Item: Object {
    dynamic var itemName = ""
    dynamic var itemDetail = ""
    dynamic var itemDate = Date()
    
}
