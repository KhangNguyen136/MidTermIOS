//
//  resultInfor.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/10/20.
//

import UIKit

class resultInfor: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func takeData(_name: String) {
        name.text = _name
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
