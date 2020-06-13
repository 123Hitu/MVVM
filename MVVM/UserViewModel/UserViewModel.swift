//
//  UserViewModel.swift
//  MVVM
//
//  Created by Hitendra on 04/06/20.
//  Copyright © 2020 Hitendra. All rights reserved.
//

import UIKit

class UserViewModel: NSObject {
    
    weak var vc : ViewController?
    var employeeModel = [EmployeModel]()
    
    static let sharedInstance = UserViewModel()
    
    func getUserData(){
        WebServiceManager.sharedInstance.getServiceCall(url: "https://5ed9e42398b7f500160dbc69.mockapi.io/api/v1/users") {(empModel: [EmployeModel]?, error) in
            if error == nil{
                self.employeeModel = empModel!
                self.vc!.tblUser.reloadData()
            }
        }
    }
    func updateEmployeImage(empId : String, imageDate : UIImage){
        var result = employeeModel.first(where: {$0.userid == empId})
        let index = employeeModel.firstIndex(where: {$0.userid == empId})
        if result != nil{
            result?.avatarImg = imageDate
            employeeModel[index!] = result!
        }
    }
}
