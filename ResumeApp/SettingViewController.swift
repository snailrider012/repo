//
//  SettingViewController.swift
//  ResumeApp
//
//  Created by Perchy Fisher on 2020/3/22.
//  Copyright © 2020 卢怡萱. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let uiImage = UIImage(named: "kitten.png")
        let avatar = UIImageView(image: uiImage)
        avatar.frame = CGRect(x: 110, y: 150, width: 180, height: 180)
        
        avatar.layer.cornerRadius = avatar.frame.size.width/2
        avatar.layer.masksToBounds = true
        avatar.layer.borderWidth = 1.5
        avatar.layer.borderColor = UIColor.black.cgColor
        
        self.view.addSubview(avatar)
        
        
        let nameLabel = UILabel()
        nameLabel.text = "用户甲"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        nameLabel.frame = CGRect(x: 100,y: 380,width: 200,height: 50)
        self.view.addSubview(nameLabel)
        
        
        let versionLabel = UILabel()
        let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
               
        versionLabel.text = "版本：\(versionNumber ?? "1.0")"
        versionLabel.textAlignment = .center
        versionLabel.font = UIFont.systemFont(ofSize: 22)
        versionLabel.frame = CGRect(x: 100,y: 450,width: 200,height: 50)
        self.view.addSubview(versionLabel)
        
    }
}
