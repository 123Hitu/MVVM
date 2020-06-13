//
//  ViewController.swift
//  MVVM
//
//  Created by Hitendra on 04/06/20.
//  Copyright © 2020 Hitendra. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tblUser : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserViewModel.sharedInstance.vc = self
        UserViewModel.sharedInstance.getUserData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detailView : DetailView = segue.destination as! DetailView
            let indexPath = tblUser.indexPath(for: sender as! UITableViewCell)
            let userData = UserViewModel.sharedInstance.employeeModel[indexPath!.row]
            detailView.empModel = userData
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserViewModel.sharedInstance.employeeModel.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as?  UserCell
        cell?.vc = self
        cell?.index = indexPath.row
        let userData = UserViewModel.sharedInstance.employeeModel[indexPath.row]
        cell?.empModel = userData
        return cell!
    }
}
