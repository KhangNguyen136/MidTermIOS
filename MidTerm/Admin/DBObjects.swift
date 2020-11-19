//
//  File.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/19/20.
//

import Foundation
import RealmSwift

class rowInfor: Object {
    @objc dynamic var lName: String = ""
    @objc dynamic var fName: String = ""
    @objc dynamic var guest: String = ""
    @objc dynamic var table: String = ""
    @objc dynamic var section: String = ""
}

class eventInfor: Object {
    @objc dynamic var _eventName: String = ""
    @objc dynamic var _fontSize: Int = 33
    @objc dynamic var _fontStyle: String = "Kefa"
    @objc dynamic var _fontColor: String = "black"
    var guestInfor = List<rowInfor>()
}
