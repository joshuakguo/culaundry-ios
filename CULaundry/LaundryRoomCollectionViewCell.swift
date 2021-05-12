//
//  LaundryRoomCollectionViewCell.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/4/21.
//

import UIKit

class LaundryRoomCollectionViewCell: UICollectionViewCell {
    
    let buildingPhoto = UIImageView()
    let laundryRoom = UILabel()
    let availableWashers = UILabel()
    let availableDryers = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.5
        layer.cornerRadius = 8
        layer.masksToBounds = false
        
        layer.backgroundColor = UIColor.white.cgColor
        
        buildingPhoto.layer.cornerRadius = 8
        buildingPhoto.layer.masksToBounds = true
        addSubview(buildingPhoto)
        
        laundryRoom.font = UIFont.systemFont(ofSize: 14)
        laundryRoom.textColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        laundryRoom.textAlignment = .center
        addSubview(laundryRoom)
        
        setUpConstraints()
        
    }
    
    func setUpConstraints() {
        buildingPhoto.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(self.frame.width * 6 / 7)
            make.height.equalTo(self.frame.height * 5 / 7)
            make.centerX.equalTo(self)
        }
        
        laundryRoom.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(buildingPhoto.snp.bottom).offset(8)
            make.right.equalTo(self)
            make.left.equalTo(self)
            make.height.equalTo(19)
        }
    }
    
    func configure(image: UIImage, text: String) {
        buildingPhoto.image = image
        laundryRoom.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
