//
//  MachineCollectionViewCell.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/10/21.
//

import UIKit

class MachineCollectionViewCell: UICollectionViewCell {
    
    let colorCode = UIView()
    let machine = UIImageView()
    let machineName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        layer.shadowColor = UIColor.lightGray.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        layer.shadowRadius = 5.0
//        layer.shadowOpacity = 1.0
//        layer.masksToBounds = false
//        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
//        layer.backgroundColor = UIColor.white.cgColor

        contentView.layer.masksToBounds = false
//        layer.cornerRadius = 8
        
        backgroundColor = .blue
        
        machineName.textColor = .white
        machineName.adjustsFontSizeToFitWidth = true
        addSubview(machineName)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        machineName.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
