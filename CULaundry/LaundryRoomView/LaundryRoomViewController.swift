//
//  ViewController.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/7/21.
//

import UIKit

class LaundryRoomViewController: UIViewController {
    
    weak var delegate: LaundryRoomDelegate?
//    let laundryRoom: LaundryRoomLong

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)

        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        
    }
    
    func setUpConstraints() {
        
    }
    
}
