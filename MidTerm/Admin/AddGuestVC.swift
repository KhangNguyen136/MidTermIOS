//
//  AddGuestVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/6/20.
//

import UIKit

class AddGuestVC: UIViewController {
    weak var addGuestDelegate: AddGuestDelegate? = nil

    @IBOutlet weak var section: UITextField!
    @IBOutlet weak var table: UITextField!
    @IBOutlet weak var numberGuest: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var fName: UITextField!
    @IBAction func clickSave(){
        if(fName.text == "" || lName.text == "" || table.text == "" || section.text == "")
        {
            let alertVC = UIAlertController(title: "Message", message: "You have to enter information!", preferredStyle: .actionSheet)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alertVC.addAction(okAction)
            alertVC.setTitlet(font: UIFont(name: "Arial", size: 30), color: .red)
            alertVC.setMessage(font: UIFont(name: "Arial", size: 22), color: .black)
            if let popoverController = alertVC.popoverPresentationController {
                            popoverController.sourceView = self.view //to set the source of your alert
                            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                        }
            self.present(alertVC, animated: true)
            return
            //bug
        }
        if Int(((lName.text?.prefix(1))!)) != nil
        {
            let alertVC = UIAlertController(title: "Message", message: "Last name can't start with number!", preferredStyle: .actionSheet)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alertVC.addAction(okAction)
            alertVC.setTitlet(font: UIFont(name: "Arial", size: 30), color: .red)
            alertVC.setMessage(font: UIFont(name: "Arial", size: 22), color: .black)
            if let popoverController = alertVC.popoverPresentationController {
                            popoverController.sourceView = self.view //to set the source of your alert
                            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                        }
            
            self.present(alertVC, animated: true)
            return
        }
        if( (Int(numberGuest.text!) == nil))
        {
            let alertVC = UIAlertController(title: "Message", message: "Number of guest must be an integer!", preferredStyle: .actionSheet)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alertVC.addAction(okAction)
            alertVC.setTitlet(font: UIFont(name: "Arial", size: 30), color: .red)
            alertVC.setMessage(font: UIFont(name: "Arial", size: 22), color: .black)
            if let popoverController = alertVC.popoverPresentationController {
                            popoverController.sourceView = self.view //to set the source of your alert
                            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                        }
            
            self.present(alertVC, animated: true)
            return
            //bug
        }
        let _fName = fName.text!
        let _lName = lName.text!
        let _num = numberGuest.text!
        let _table = table.text!
        let _section = section.text!
        addGuestDelegate?.didAddGuest(fName: _fName,lName: _lName, guest: _num, table: _table, section: _section)
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func clickExit(){
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    //Set title font and title color
    func setTitlet(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                          range: NSMakeRange(0, title.utf8.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
    
    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}
