//
//  ViewController.swift
import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func toAdmin(){
        
        let dest = self.storyboard?.instantiateViewController(identifier: "HomeAdminVC") as! HomeAdminVC

        self.navigationController?.pushViewController(dest, animated: true)
    }
    @IBAction func toGuest(){
        let dest = self.storyboard?.instantiateViewController(identifier: "GuestHomeVC") as! GuestHomeVC
        self.navigationController?.pushViewController(dest, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

