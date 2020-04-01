//
//  LoadMoreTableCell.swift
//  ResumeApp
//
//  Created by Perchy Fisher on 2020/3/24.
//  Copyright © 2020 卢怡萱. All rights reserved.
//

import UIKit

class LoadMoreTableCell: UITableViewCell {
    
    var loadingView: UIActivityIndicatorView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadingView = UIActivityIndicatorView(style: .medium)
        self.contentView.addSubview(loadingView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadingView.center = self.contentView.center
    }
}
