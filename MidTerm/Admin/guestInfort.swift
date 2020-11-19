//
//  guestInfort.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/6/20.
//

import UIKit

class guestInfort: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var section: UITextField!
    @IBOutlet weak var table: UITextField!
    @IBOutlet weak var guest: UITextField!
    @IBOutlet weak var name: UITextField!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func takeData(_name: String,_guest: String, _table: String, _section: String)  {
        name.text = _name
        guest.text = _guest
        table.text = _table
        section.text = _section
    }

}
