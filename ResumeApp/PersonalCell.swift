//
//  PersonalCell.swift
//  ResumeApp
//
//  Created by Perchy Fisher on 2020/3/27.
//  Copyright © 2020 卢怡萱. All rights reserved.
//

import UIKit

class PersonalCell: UITableViewCell {
    
    var iconView : UIImageView!
    var nameLabel : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconView = UIImageView()
        iconView.frame = CGRect(x: 20,y: 20,width: 80,height: 80)
        self.contentView.addSubview(iconView)
        
        nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.frame = CGRect(x:iconView.frame.maxX + 20, y: 20, width: 200, height: 80)
        self.contentView.addSubview(nameLabel)
        
        self.contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
