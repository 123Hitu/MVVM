//
//  UserCell.swift
//  MVVM
//
//  Created by Hitendra on 04/06/20.
//  Copyright © 2020 Hitendra. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var userImage : CustomImageView?
    var index:Int = 0
    
    var vc : ViewController?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userImage?.image = nil
    }
    
    var empModel : EmployeModel?{
        didSet{
            self.updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func updateCell(){
        lblUserName.text = empModel?.name
        lblDate.text = self.getFormatedDate()
        self.userImage?.image = UIImage(named: "NoImage")
        self.userImage?.downloadImageFrom(withUrl: empModel!.avatar!)
//        if self.empModel?.avatarImg == nil {
//            self.downloadImage(self.empModel!)
//        } else {
//            self.userImage?.image = self.empModel?.avatarImg
//        }
    }
    
    func downloadImage(_ empModel : EmployeModel){
        WebServiceManager.sharedInstance.downlodImage((empModel.avatar)!) { (date, error) in
            if error == nil{
                let image = UIImage(data: date! as Data)
                self.userImage?.image = image
                self.userImage?.contentMode = .scaleAspectFit
                UserViewModel.sharedInstance.updateEmployeImage(empId: (empModel.userid)!, imageDate: image!)
            }
        }
    }
    
    func getFormatedDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateArray = (empModel?.createdAt)?.components(separatedBy: "T")
        let date = formatter.date(from: (dateArray?.first!)!)
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date!)
    }
}



