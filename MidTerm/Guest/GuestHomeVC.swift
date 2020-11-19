//
//  GuestHomeVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/9/20.
//

import UIKit

class GuestHomeVC: UIViewController {

    @IBAction func clickHome(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func toFindTable(){
        let dest = self.storyboard?.instantiateViewController(identifier: "fliterTableVC") as! fliterTableVC
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
