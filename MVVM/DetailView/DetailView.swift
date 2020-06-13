//
//  DetailView.swift
//  MVVM
//
//  Created by Hitendra on 04/06/20.
//  Copyright © 2020 Hitendra. All rights reserved.
//

import UIKit

class DetailView: UIViewController {

    var empModel : EmployeModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func goBack(_ sender : AnyObject ){
        self.navigationController?.popViewController(animated: true)
    }
}
