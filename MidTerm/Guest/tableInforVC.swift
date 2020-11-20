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
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var title4: UILabel!
    @IBOutlet weak var table: UILabel!
    @IBOutlet weak var guests: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var otherView: UIView!
    var infor = rowInfor()
    var arr:[rowInfor] = []
    let realm = try! Realm()
    override func viewDidLoad() {
        otherView.layer.borderWidth = 10
        otherView.layer.borderColor = UIColor.black.cgColor
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
        
        let result = try! realm.objects(rowInfor.self).filter({$0.table == temp.table && $0 != temp})
        if(result.isEmpty)
        {
            return
        }
        else
        {
            for i in result
            {
                if i.fName != infor.fName || i.lName != infor.lName || i.guest != infor.guest || i.section != infor.section {
                    arr.append(i)
                }
            }
//
            tableInfor.reloadData()
        }
        
    }
    func setTitle()  {
       
        let infor = realm.objects(eventInfor.self)
        if infor.isEmpty
        {
            return
        }
        name.font = UIFont(name: infor[0]._fontStyle, size: CGFloat(infor[0]._fontSize))
        name.textColor = UIColor().getMyColor(color: infor[0]._fontColor)
        
        title1.font = UIFont(name: infor[0]._fontStyle, size: CGFloat(infor[0]._fontSize))
        title1.textColor = UIColor().getMyColor(color: infor[0]._fontColor)
        title1.adjustsFontSizeToFitWidth = true
        title2.font = UIFont(name: infor[0]._fontStyle, size: CGFloat(infor[0]._fontSize))
        title2.textColor = UIColor().getMyColor(color: infor[0]._fontColor)
        title2.adjustsFontSizeToFitWidth = true
        
        title3.font = UIFont(name: infor[0]._fontStyle, size: CGFloat(infor[0]._fontSize))
        title3.textColor = UIColor().getMyColor(color: infor[0]._fontColor)
        title3.adjustsFontSizeToFitWidth = true
        
        title4.font = UIFont(name: infor[0]._fontStyle, size: CGFloat(infor[0]._fontSize))
        title4.textColor = UIColor().getMyColor(color: infor[0]._fontColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        table.layer.masksToBounds = true
        table.layer.cornerRadius = table.frame.width/3
        table.backgroundColor = UIColor.systemPink
        
        guests.layer.borderWidth = 5
        guests.layer.borderColor = UIColor.brown.cgColor
        guests.layer.cornerRadius = guests.frame.width/4
        guests.layer.masksToBounds = true
        guests.backgroundColor = UIColor.systemGreen
        
        section.layer.borderWidth = 5
        section.layer.borderColor =  UIColor.black.cgColor
        section.backgroundColor = UIColor.systemYellow
        
        setTitle()
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
