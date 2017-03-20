//
//  UserCell.swift
//  Snapchat_clone
//
//  Created by Alfredo M. on 3/20/17.
//  Copyright © 2017 Alfredo M. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var firstNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckmark(selected: false)
    }

    func updateUI(user : User) {
        firstNameLbl.text = user.firstName
    }
    
    func setCheckmark(selected: Bool) {
        let imageStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView (image: UIImage(named: imageStr))
    }

    

}
