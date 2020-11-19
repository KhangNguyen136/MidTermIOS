//
//  pickFontAlertVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/18/20.
//

import UIKit

class pickFontAlertVC: UIAlertController {

    var listFont:[String] = UIFont.familyNames
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(true)
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

extension pickFontAlertVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listFont.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let temp = UILabel()

        temp.numberOfLines = 0
        let title = NSAttributedString(string: listFont[row], attributes: [NSAttributedString.Key.font: UIFont(name: listFont[row], size: 20) ?? UIFont(name: "Arial", size: 20)!])
        temp.attributedText = title
        temp.sizeToFit()
        temp.textAlignment = NSTextAlignment.center
        
        return temp
    }
    
}
