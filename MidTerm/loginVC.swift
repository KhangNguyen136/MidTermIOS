//
//  loginVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/19/20.
//

import UIKit

class loginVC: UIViewController {

    let key = "18120405"
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var btn: UIButton!
    @IBAction func clickSubmit(){
        if(username.text == key && pass.text == key){
            let dest = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(dest, animated: true)
        }
        else
        {
            let alertVC = UIAlertController(title: "Message", message: "Username or password is wrong!", preferredStyle: .actionSheet)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alertVC.addAction(okAction)
            alertVC.setTitlet(font: UIFont(name: "Arial", size: 30), color: .red)
            alertVC.setMessage(font: UIFont(name: "Arial", size: 25), color: .black)
            if let popoverController = alertVC.popoverPresentationController {
                            popoverController.sourceView = self.view //to set the source of your alert
                            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                        }
            
            self.present(alertVC, animated: true)
        }
    }
    @IBAction func clickForgetPass(){
        let alertVC = UIAlertController(title: "Hint", message: "Student code: 18120405", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(okAction)
        alertVC.setTitlet(font: UIFont(name: "Arial", size: 30), color: .red)
        alertVC.setMessage(font: UIFont(name: "Arial", size: 25), color: .black)
        if let popoverController = alertVC.popoverPresentationController {
                        popoverController.sourceView = self.view //to set the source of your alert
                        popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                        popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                    }
        
        self.present(alertVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = btn.frame.width/6
        btn.layer.backgroundColor = UIColor.systemTeal.cgColor
        
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
