//
//  SettingsTableViewCell.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/1/21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    let cellText = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.backgroundColor = .white
        
        setUpViews()
        setUpConstraints()
        
    }
    
    func setUpViews() {
        cellText.font = UIFont.systemFont(ofSize: 15)
        cellText.textColor = .black
        cellText.numberOfLines = 0
        contentView.addSubview(cellText)
        
    }
    
    func setUpConstraints() {
        cellText.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
    }
    
    func configure(with text: String) {
        cellText.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
