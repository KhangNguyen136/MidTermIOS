//
//  HomeAdminVCViewController.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/5/20.
//

import UIKit
import RealmSwift

class HomeAdminVC: UIViewController {
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    func editBtn(btn: UIButton)  {
        btn.layer.borderWidth = 5
        btn.layer.borderColor = UIColor.green.cgColor
        btn.layer.cornerRadius = 10
    }
    @IBAction func clickExit(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func createNewEvent(){
        let alertVC = UIAlertController(title: "Warning!!!", message: "Create new event will delete all informations of current event in the app.", preferredStyle: .actionSheet)

        let okAction = UIAlertAction(title: "Continue", style: .destructive)
        {_ in
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
            let dest = self.storyboard?.instantiateViewController(identifier: "EventMainVC") as! EventMainVC
            dest.action = "Create new event"
            self.navigationController?.pushViewController(dest, animated: true)
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        {_ in
            return
        }
        alertVC.addAction(cancelAction)
        alertVC.setTitlet(font: UIFont(name: "Arial", size: 25), color: .red)
        alertVC.setMessage(font: UIFont(name: "Arial", size: 20), color: .black)
        if let popoverController = alertVC.popoverPresentationController {
                        popoverController.sourceView = self.view //to set the source of your alert
                        popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                        popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                    }
        self.present(alertVC, animated: true, completion: nil)
        
    }
        
    
    @IBAction func editCurrentEvent(){
        let dest = storyboard?.instantiateViewController(identifier: "EventMainVC") as! EventMainVC
        self.navigationController?.pushViewController(dest, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        editBtn(btn: btn1)
        editBtn(btn: btn2)
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
