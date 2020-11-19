//
//  EventMainVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/6/20.
//

import UIKit
import RealmSwift


protocol AddGuestDelegate: class {
    func didAddGuest(fName: String,lName: String,guest: String, table: String, section: String)
}

class EventMainVC: UIViewController, AddGuestDelegate, UIFontPickerViewControllerDelegate, UIColorPickerViewControllerDelegate {
    
    var event = eventInfor()
    var myColor = "black"
    let realm = try! Realm()
    var action = "Edit current event"
    @IBOutlet weak var titleVC: UILabel!
    @IBOutlet weak var listTV: UITableView!
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var fontStyle: UILabel!
    @IBOutlet weak var fontSize: UILabel!
    @IBOutlet weak var sizeValue: UISlider!
    @IBOutlet weak var fontColor: UILabel!
    
    @IBAction func takeSize(_ sender: Any) {
        fontSize.text = String(Int(sizeValue.value))
    }
    @IBAction func chooseFontStyle(){
        
        let pickerFontVC = UIViewController()
        pickerFontVC.preferredContentSize = CGSize(width: 300, height: 200)
        let pickerFontView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        
        
        pickerFontVC.view.addSubview(pickerFontView)
        //create alert
        let alertVC = pickFontAlertVC(title: "Choose font style", message: nil, preferredStyle: .alert )
        
        alertVC.setValue(pickerFontVC, forKey: "contentViewController")
        pickerFontView.delegate = alertVC
        pickerFontView.dataSource = alertVC
        
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        {_ in
            
            self.fontStyle.font = UIFont(name: alertVC.listFont[pickerFontView.selectedRow(inComponent: 0)], size: 22)
            self.fontStyle.text = alertVC.listFont[pickerFontView.selectedRow(inComponent: 0)]
            return
        }
        alertVC.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        {_ in
            return
        }
        alertVC.addAction(cancelAction)
        
        alertVC.setTitlet(font: UIFont(name: "Arial", size: 25), color: .black)
        
        //set select row to current font style of event
        pickerFontView.selectRow(alertVC.listFont.firstIndex(of: fontStyle.text!) ?? 0, inComponent: 0, animated: true)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    @IBAction func chooseFontColor(){
        //create picker viewController for colorPickerAleart
        let pickerFontVC = UIViewController()
        
        pickerFontVC.preferredContentSize = CGSize(width: 300, height: 150)
        
        let pickerFontView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        
        
        
        pickerFontVC.view.addSubview(pickerFontView)
        
        let alertVC = pickColorAlertVC(title: "Choose font color", message: nil, preferredStyle: .alert )

        
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        {_ in
            self.fontColor.backgroundColor = UIColor().getMyColor(color: alertVC.choices[ pickerFontView.selectedRow(inComponent: 0)])
            
            self.myColor = alertVC.choices[pickerFontView.selectedRow(inComponent: 0)]
            return
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        {_ in
            return
        }
        alertVC.addAction(cancelAction)
        alertVC.setTitlet(font: UIFont(name: "Arial", size: 35), color: .black)
  

        alertVC.setValue(pickerFontVC, forKey: "contentViewController")
        pickerFontView.delegate = alertVC
        pickerFontView.dataSource = alertVC
        //set select row = current color of event
        pickerFontView.selectRow(alertVC.choices.firstIndex(of: self.myColor) ?? 6, inComponent: 0, animated: true)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    
    @IBAction func clickEdit(){
        listTV.isEditing = !listTV.isEditing
    }
    @IBAction func clickSave(_ sender: Any) {
        //update db
            try! realm.write{
                event._eventName = eventName.text!
                event._fontSize = Int(sizeValue.value)
                event._fontStyle = fontStyle.text!
                event._fontColor = myColor
            }
    }
    @IBAction func addGuest(){
        
        let dest = storyboard?.instantiateViewController(identifier: "AddGuestVC") as! AddGuestVC
        dest.addGuestDelegate = self
        
        self.navigationController?.pushViewController(dest, animated: true)
    }
    @IBAction func cliclExit(){
        self.navigationController?.popViewController(animated: true)
    }
    func didAddGuest(fName: String,lName: String,guest: String, table: String, section: String)
    {
        let temp = rowInfor()
        temp.fName = fName
        temp.lName = lName
        temp.guest = guest
        temp.table = table
        temp.section = section
        //save data to db
        
        try! realm.write {
            event.guestInfor.append(temp)
        }
        
        listTV.beginUpdates()
        listTV.insertRows(at: [IndexPath(row: event.guestInfor.count-1, section: 0)], with: .automatic)
        listTV.endUpdates()
        
       
        
    }
    
    func getDataFromDB() {
        let infor = realm.objects(eventInfor.self)
        if infor.isEmpty
        {
            try! realm.write{
                realm.add(event)
            }
        }
        else{
            event = infor[0]
        }
        sizeValue.value = Float(event._fontSize)
        eventName.text = event._eventName
        fontSize.text = String(event._fontSize)
        fontStyle.text = event._fontStyle
        fontColor.backgroundColor = UIColor().getMyColor(color: event._fontColor)
        myColor = event._fontColor
        listTV.reloadData()
        
        titleVC.text = action
        print(realm.configuration.fileURL!)
    }
    override func viewDidLoad() {
        

        // Do any additional setup after loading the view.
        listTV.register(guestInfort.self, forCellReuseIdentifier: "guestInfor")
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        getDataFromDB()
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
extension EventMainVC : UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.guestInfor.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell: guestInfort = listTV.dequeueReusableCell(withIdentifier: "row", for: indexPath) as! guestInfort
        
        cell.takeData(_name: event.guestInfor[indexPath.row].fName+" , "+event.guestInfor[indexPath.row].lName, _guest: event.guestInfor[indexPath.row].guest, _table: event.guestInfor[indexPath.row].table, _section: event.guestInfor[indexPath.row].section)
        
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempCell = event.guestInfor[sourceIndexPath.row]
        try! realm.write{
        event.guestInfor.remove(at: sourceIndexPath.row)
        event.guestInfor.insert(tempCell,at: destinationIndexPath.row)
        }
        //update db
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write{

                realm.delete(event.guestInfor[indexPath.row])
            }
            tableView.reloadData()
            
            //update db
        }
    }
}




