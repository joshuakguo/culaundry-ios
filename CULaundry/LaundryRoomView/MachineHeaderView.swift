//
//  MachineHeaderView.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/10/21.
//

import UIKit

class MachineHeaderView: UICollectionReusableView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = ""
        label.textColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        addSubview(label)
        
        label.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 5, bottom: 20, right: 0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
