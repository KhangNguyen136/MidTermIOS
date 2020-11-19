//
//  chooseTableVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/12/20.
//

import UIKit
import RealmSwift
class chooseTableVC: UIViewController {

    var key: String = ""
    @IBOutlet weak var titleVC: UILabel!
    @IBOutlet weak var resultTV: UITableView!
    var result: [rowInfor] = []
    let realm = try! Realm()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
                // Do any additional setup after loading the view.
    }
    
    func getData(by: String) {
        
        let infor = realm.objects(rowInfor.self).filter{ $0.lName.lowercased().hasPrefix(by.lowercased()) }
        if(infor.isEmpty)
        {
            //titleVC.text = "There is no result with last name begins with \(by)"
            print("No result")
        }
        else
        {
            for i in infor
            {
                result.append(i)
                
            }
            resultTV.reloadData()
        }
        
    }
    @IBAction func clickHome(){
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        resultTV.register(resultInfor.self, forCellReuseIdentifier: "resultInfor")
        self.getData(by: key)
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
extension chooseTableVC : UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell: resultInfor = resultTV.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! resultInfor
        
        cell.takeData(_name: result[indexPath.row].fName+" , "+result[indexPath.row].lName)
        
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if(resultTV.cellForRow(at: indexPath)?.isSelected == true)
            {
                let dest = self.storyboard?.instantiateViewController(identifier: "tableInforVC") as! tableInforVC
                self.navigationController?.pushViewController(dest, animated: true)
                dest.infor = result[indexPath.row]
                //dest.takeData(temp: result[indexPath.row])
            }
        }
   
}
