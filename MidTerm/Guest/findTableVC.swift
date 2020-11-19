//
//  findTableVC.swift
//  MidTerm
//
//  Created by Khang Nguyen on 11/9/20.
//

import UIKit
import RealmSwift

class findTableVC: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var listResultTV: UITableView!

    let realm = try! Realm()
    var event = eventInfor()
    var result:[rowInfor] = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    func getData() -> Bool {
        let temp = realm.objects(eventInfor.self)
        if(temp.isEmpty)
        {
            return false
        }
        event = temp[0]
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter your name"
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        
        
        if(getData() == false)
        {
            let alertVC = UIAlertController(title: "Message", message: "There is no information of event!", preferredStyle: .actionSheet)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alertVC.addAction(okAction)
            
            if let popoverController = alertVC.popoverPresentationController {
                            popoverController.sourceView = self.view //to set the source of your alert
                            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                        }
            
            self.present(alertVC, animated: true)
            listResultTV.register(resultInfor.self, forCellReuseIdentifier: "resultInfor")
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func filterContentForSearchText(_ searchText: String) {
        
        result = event.guestInfor.filter { (temp: rowInfor) -> Bool in
            return temp.lName.lowercased().contains(searchText.lowercased())
      }
      
      listResultTV.reloadData()
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
extension findTableVC: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
  }
}

extension findTableVC : UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return result.count
          }
            
        return event.guestInfor.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let temp: resultInfor = listResultTV.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! resultInfor
        
        
        if isFiltering
        {
            temp.takeData(_name: result[indexPath.row].fName+" , "+result[indexPath.row].lName)
        }
        else
        {
            temp.takeData(_name: event.guestInfor[indexPath.row].fName+" , "+event.guestInfor[indexPath.row].lName)
        }
        
        return temp
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempCell = event.guestInfor[sourceIndexPath.row]
        try! realm.write{
        event.guestInfor.remove(at: sourceIndexPath.row)
        event.guestInfor.insert(tempCell,at: destinationIndexPath.row)
        }
        //update db
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write{

                realm.delete(event.guestInfor[indexPath.row])
            }
            tableView.reloadData()
            
            //update db
        }
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if(listResultTV.cellForRow(at: indexPath)?.isSelected == true)
            {
            
            }
        }
    
}

