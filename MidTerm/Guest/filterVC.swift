//
//  filterVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/12/20.
//

import UIKit
import RealmSwift

class fliterTableVC: UIViewController {


    @IBOutlet weak var titleVC: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
    func getData() {
        let realm = try! Realm()
        let infor = realm.objects(eventInfor.self)
        if infor.isEmpty
        {
            return
        }
        
        titleVC.text = "Please select your last name initial!"
        titleVC.font = UIFont(name: infor[0]._fontStyle, size: CGFloat(infor[0]._fontSize))
        titleVC.textColor = UIColor().getMyColor(color: infor[0]._fontColor)
    }
    override func viewWillAppear(_ animated: Bool) {
        getData()
        getAllButton(view: self.view)
//        homeBtn.layer.borderWidth = 0
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    func getAllButton(view: UIView)
    {
        for insideView in view.subviews{
            if insideView.subviews.count>0
            {
            getAllButton(view: insideView)
            }
            else if(insideView.isKind(of: UIButton.self)){
                            insideView.layer.borderWidth = 2.0
                insideView.layer.borderColor = UIColor.orange.cgColor
                insideView.layer.cornerRadius = insideView.frame.width/4
            }
        }
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
