//
//  GuestHomeVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/9/20.
//

import UIKit
import RealmSwift

class GuestHomeVC: UIViewController {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    func getData(){
        let realm = try! Realm()
        let infor = realm.objects(eventInfor.self)
        if infor.isEmpty
        {
            return
        }
        if(infor[0]._eventName != "")
        {
        eventName.text = infor[0]._eventName
        }
        eventName.font = UIFont(name: infor[0]._fontStyle, size: CGFloat(infor[0]._fontSize))
        eventName.textColor = UIColor().getMyColor(color: infor[0]._fontColor)
    }
    @IBAction func clickHome(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func toFindTable(){
        let dest = self.storyboard?.instantiateViewController(identifier: "fliterTableVC") as! fliterTableVC
        self.navigationController?.pushViewController(dest, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = btn.frame.width/4
        
        btn.layer.borderWidth = 5
        btn.layer.borderColor = UIColor.systemPurple.cgColor
        getData()
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
