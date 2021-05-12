//
//  MachineCollectionViewCell.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/10/21.
//

import UIKit

class MachineCollectionViewCell: UICollectionViewCell {
    
    var isAvailable: Int = 0
    var isOOS: Int = 0
    var isOffline: Int = 0
    var isWasher: Int = 0
    var timeRemainingInt: Int = 0
    
    let colorCode = UIView()
    let machine = UIImageView()
    let machineCircle = UIImageView()
    let machineName = UILabel()
    let timeRemaining = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.masksToBounds = false

        addSubview(machine)
        
        machineName.textColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        machineName.adjustsFontSizeToFitWidth = true
        machineName.font = UIFont.boldSystemFont(ofSize: 16)
        machineName.textAlignment = .left
        addSubview(machineName)
        
        timeRemaining.textColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        timeRemaining.adjustsFontSizeToFitWidth = true
        timeRemaining.font = UIFont.systemFont(ofSize: 10)
        timeRemaining.textAlignment = .left
        addSubview(timeRemaining)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        machine.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.width.equalTo(72)
            make.height.equalTo(73)
        }
        machineName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(machine.snp.right).offset(5)
            make.right.equalTo(self)
            make.height.equalTo(19)
        }
        timeRemaining.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(machineName.snp.bottom).offset(5)
            make.left.equalTo(machine.snp.right).offset(5)
            make.right.equalTo(self)
            make.height.equalTo(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
