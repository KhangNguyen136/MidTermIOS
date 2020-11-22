//
//  loginVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/19/20.
//

import UIKit

struct loginInfor : Codable {
    let username: String
    let password: String
}

class loginVC: UIViewController {

//    var loginKey = loginInfor(username: "", password: "")
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var btn: UIButton!
    @IBAction func clickSubmit(){
        if(username.text != "" && pass.text != "")
        {
            checkLogin(username: username.text ?? "", password: pass.text ?? "")
            
        }
        else
        {
            let alertVC = UIAlertController(title: "Login failed", message: "Please enter username and password!", preferredStyle: .actionSheet)
            
                        let okAction = UIAlertAction(title: "Ok", style: .default)
                        alertVC.addAction(okAction)
                        
                        if let popoverController = alertVC.popoverPresentationController {
                                        popoverController.sourceView = self.view //to set the source of your alert
                                        popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                                        popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                                    }
            alertVC.setTitlet(font: UIFont(name: "Arial", size: 33), color: .red)
            alertVC.setMessage(font: UIFont(name: "Arial", size: 25), color: .black)
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
    func checkLogin(username: String, password: String) {
        
        let address = "https://5fb6a70f36e2fa00166a5ad7.mockapi.io/login"
        
        guard let loginURL = URL(string: address) else {
            print("Can't get URL from \(address)")
            return  }
        
        let request = NSMutableURLRequest(url: loginURL)
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest)
        {
        (data,respond,error) in
            guard let data = data, error == nil, respond != nil else
            {
                    DispatchQueue.main.async
                    {
                        let alertVC = UIAlertController().makeMyAlert(title: "Message", msg: "Fail to get data from database, check your connection!")
                    if let popoverController = alertVC.popoverPresentationController {
                                    popoverController.sourceView = self.view //to set the source of your alert
                                    popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                                    popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                                }
                    self.present(alertVC, animated: true)
                        }
                    
                return
            }
            do
             {
                let decoder = JSONDecoder()
                let temp = try! decoder.decode(loginInfor.self, from: data)
                DispatchQueue.main.async {
                    
                    if(temp.username == username && temp.password == password)
                        {
                                let dest = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                                self.navigationController?.pushViewController(dest, animated: true)
                        }
                        else
                            {
                                let alertVC = UIAlertController().makeMyAlert(title: "Login failed", msg: "Username or password is wrong!")
                                if let popoverController = alertVC.popoverPresentationController {
                                                popoverController.sourceView = self.view //to set the source of your alert
                                                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                                                popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                                            }
                                self.present(alertVC, animated: true)
                            }
                }
            }
        }
            
        task.resume()
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
