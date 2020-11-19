//
//  tableInforVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/9/20.
//

import UIKit
import RealmSwift
class tableInforVC: UIViewController {

    @IBOutlet weak var tableInfor: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var table: UILabel!
    @IBOutlet weak var guests: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var otherView: UIView!
    var infor = rowInfor()
    var arr:[rowInfor] = []
    let realm = try! Realm()
    override func viewDidLoad() {
        otherView.layer.borderWidth = 2
        otherView.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        super.viewDidLoad()
        tableInfor.register(sameTableCell.self, forCellReuseIdentifier: "sameTableCell")
        takeData(temp: infor)
        // Do any additional setup after loading the view.
        
    }
    @IBAction func clickHome(){
        self.navigationController?.popViewController(animated: true)
    }
    func takeData(temp: rowInfor) {
        infor = temp
        name.text = infor.fName + " , " + infor.lName
        table.text = infor.table
        guests.text = infor.guest
        section.text = infor.section
        
        let result = try! realm.objects(rowInfor.self).filter({$0.table == temp.table})
        if(result.isEmpty)
        {
            return
        }
        else
        {
            for i in result
            {
                arr.append(i)
            }
            tableInfor.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension tableInforVC : UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count+1;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: sameTableCell = tableInfor.dequeueReusableCell(withIdentifier: "sameTableRow", for: indexPath) as! sameTableCell
            
            cell.getData(_name: "Guest Name: ", _guests: "Guests:")
            
            return cell
        }
        let cell: sameTableCell = tableInfor.dequeueReusableCell(withIdentifier: "sameTableRow", for: indexPath) as! sameTableCell
        
        cell.getData(_name: arr[indexPath.row-1].fName + " , " + arr[indexPath.row-1].lName, _guests: arr[indexPath.row-1].guest)
        
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
   
}


class sameTableCell: UITableViewCell{
    
    @IBOutlet weak var guests: UILabel!
    @IBOutlet weak var name: UILabel!
    func getData(_name: String, _guests: String) {
        name.text = _name
        guests.text = _guests
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
