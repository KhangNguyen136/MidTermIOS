//
//  filterVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/12/20.
//

import UIKit

class fliterTableVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //AButton.addTarget(self, action: #selector(clickChar(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @IBAction func clickChar( sender: UIButton!){
        if let temp = sender.titleLabel?.text {
        
        fliterBy(char: temp)
        }
    }
    
    @IBAction func clickHome(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func fliterBy(char: String)  {
        let dest = self.storyboard?.instantiateViewController(identifier: "chooseTableVC") as! chooseTableVC
        dest.key = char
        self.navigationController?.pushViewController(dest, animated: true)
        
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
extension UINavigationController {
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }

    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
