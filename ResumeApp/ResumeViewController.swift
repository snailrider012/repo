//
//  ResumeViewController.swift
//  ResumeApp
//
//  Created by Perchy Fisher on 2020/3/23.
//  Copyright © 2020 卢怡萱. All rights reserved.
//

import UIKit
import WebKit

class ResumeViewController: UIViewController {    
    let scroll = UIScrollView()
    let nameLabel = UILabel()
    let infoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.titleView = UIView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(backAction))
        
        scroll.frame = self.view.bounds
        scroll.backgroundColor = UIColor.systemBackground
        scroll.contentSize = CGSize(width: self.view.frame.width, height:600)
        scroll.delegate = self as? UIScrollViewDelegate
        self.view.addSubview(scroll)
        
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.text = "我的简历"
        nameLabel.textAlignment = .center
        nameLabel.frame = CGRect(x: 100,y: 30,width: 200,height: 50)
        scroll.addSubview(nameLabel)
        
        
        infoLabel.font = UIFont.systemFont(ofSize: 18)
        infoLabel.textAlignment = .center
        infoLabel.text = "即将毕业于北京某重点大学。"
        infoLabel.textColor = .white
        infoLabel.backgroundColor = .darkGray
        infoLabel.numberOfLines = 2
        infoLabel.frame = CGRect(x: 70,y: 100,width: 260,height: 70)
        scroll.addSubview(infoLabel)
        
        
        let informLabel = UILabel()
        informLabel.text = "曾在母校校庆中当任理事；\n在某著名公司中有过当任软件工程师；\n随时可入职，每周可实习五天。"
        informLabel.frame = CGRect(x: 70, y: 200, width: 280, height: 130)
        informLabel.font = UIFont.systemFont(ofSize: 18)
        informLabel.numberOfLines = 0
        scroll.addSubview(informLabel)
    }

    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}


