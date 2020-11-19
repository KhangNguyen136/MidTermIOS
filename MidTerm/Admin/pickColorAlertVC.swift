//
//  pickColorAlertVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/18/20.
//

import UIKit

class pickColorAlertVC: UIAlertController {
    
    var choices = ["brown","teal","indigo","pink","red","blue","black","cyan","mangenta","yellow","gray","green","orange","purple"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
extension pickColorAlertVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let result = UIView()
        let title = UILabel()
        title.numberOfLines = 0
        title.text = choices[row]
        title.textColor = UIColor().getMyColor(color: choices[row])
        title.font = UIFont(name: "Arial", size: 35)
        title.textAlignment = .center
        let colorField = UILabel()
        colorField.numberOfLines = 0
//        temp.sizeToFit()
        colorField.backgroundColor = UIColor().getMyColor(color: choices[row])
        
        //set contraints
//        title.addConstraint(NSLayoutConstraint(item: title, attribute: .leading, relatedBy: .equal, toItem: result, attribute: .leading, multiplier: 1, constant: 10))
//        title.addConstraint(NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: result, attribute: .top, multiplier: 1, constant: 1))
//        title.addConstraint(NSLayoutConstraint(item: title, attribute: .bottom, relatedBy: .equal, toItem: result, attribute: .bottom, multiplier: 1, constant: 1))
//
//        colorField.addConstraint(NSLayoutConstraint(item: colorField, attribute: .leading, relatedBy: .equal, toItem: title, attribute: .trailing, multiplier: 1, constant: 2))
//        colorField.addConstraint(NSLayoutConstraint(item: colorField, attribute: .top, relatedBy: .equal, toItem: result, attribute: .top, multiplier: 1, constant: 0))
//        colorField.addConstraint(NSLayoutConstraint(item: colorField, attribute: .bottom, relatedBy: .equal, toItem: result, attribute: .bottom, multiplier: 1, constant: 0))
//        colorField.addConstraint(NSLayoutConstraint(item: colorField, attribute: .trailing, relatedBy: .equal, toItem: result, attribute: .trailing, multiplier: 1, constant: 0))
        
        
        result.addSubview(title)
        result.addSubview(colorField)
        return title
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}

extension UIColor {
    func getMyColor(color: String) -> UIColor{
        switch color {
        case "brown":
            return UIColor.brown
        case "teal":
            return UIColor.systemTeal
        case "indigo":
            return UIColor.systemIndigo
        case "black":
            return UIColor.black
        case "blue":
            return UIColor.blue
        case "red":
            return UIColor.red
        case "cyan":
            return UIColor.cyan
        case "pink":
            return UIColor.systemPink
        case "mangenta":
            return UIColor.magenta
        case "yellow":
            return UIColor.yellow
        case "gray":
            return UIColor.gray
        case "green":
            return UIColor.green
        case "orange":
            return UIColor.orange
        case "purple":
            return UIColor.purple
        default:
            return UIColor.clear
        }
    }
}
