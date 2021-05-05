//
//  SettingsTableHeaderView.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/1/21.
//

import UIKit

class SettingsTableHeaderView: UITableViewHeaderFooterView {
    
    let background = UIView()
    let header = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        
        background.backgroundColor = .clear
        addSubview(background)
        
        header.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        header.font = UIFont(name: "Roboto-Regular", size: 13)
        addSubview(header)
        
        background.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        header.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(background)
            make.height.equalTo(20)
            make.left.equalTo(background).offset(10)
            make.right.equalTo(background)
//            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        }
        
    }
    
    func configure(headerText: String) {
        header.text = headerText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
