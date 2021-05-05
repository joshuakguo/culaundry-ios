//
//  ViewController.swift
//  CULaundry
//
//  Created by Joshua Guo on 4/30/21.
//

import UIKit
import SnapKit
import DropDown

class ViewController: UIViewController {
    
    private let cornellRed: UIColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
    
    let fakeLaundryRooms = ["Balch Hall", "Bauer Hall", "Clara Dickson Hall", "Court Hall", "George Jameson Hall", "Kay Hall", "Mary Donlon Hall"]
    
    // NEXT PUSH, ALSO UPDATE THE GITIGNORE, GOOGLE THE GIT COMMANDS
    let settingsButton = UIBarButtonItem()
    let navigationView = UIView()
    let titleView = UILabel()
    let selectionView = UIView()
    let selectionTextView = UILabel()
    let dropDown = DropDown()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        createDummyData()
        setUpViews()
        setUpConstraints()
        
    }
    
    func createDummyData() {
        
    }
    
    func setUpViews() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = cornellRed
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font : UIFont(name: "Roboto-Bold", size: 14)!]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.backButtonTitle = "Back"
        
        navigationItem.rightBarButtonItem = settingsButton
        settingsButton.image = UIImage(systemName: "gearshape.fill")
        settingsButton.tintColor = .white
        settingsButton.action = #selector(settingsButtonPressed)
        settingsButton.target = self
        
        navigationView.backgroundColor = cornellRed
        view.addSubview(navigationView)
        
        titleView.textColor = .white
        titleView.font = UIFont(name: "Roboto-Black", size: 35)
        titleView.text = "Laundry Rooms"
        titleView.textAlignment = .left
        view.addSubview(titleView)
        
        selectionView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        selectionView.layer.cornerRadius = 8
        view.addSubview(selectionView)
        
        selectionTextView.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        selectionTextView.font = UIFont(name: "Roboto-Regular", size: 16)
        selectionTextView.text = "Select a Laundry Room"
        selectionTextView.textAlignment = .left
        selectionTextView.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(showDropDown))
        selectionTextView.addGestureRecognizer(labelTapGesture)
        view.addSubview(selectionTextView)
        
        dropDown.anchorView = selectionTextView
        dropDown.dataSource = fakeLaundryRooms
        dropDown.dismissMode = .automatic
        DropDown.appearance().textColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        DropDown.appearance().selectedTextColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectedLaundryRoom(index: index, item: item)
        }
    }
    
    func setUpConstraints() {
        navigationView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(110)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(navigationView)
            make.height.equalTo(47)
            make.left.equalTo(navigationView).inset(15)
            make.right.equalTo(navigationView).inset(-15)
        }
        
        selectionView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(navigationView).offset(-15)
            make.height.equalTo(40)
            make.left.equalTo(navigationView).offset(15)
            make.right.equalTo(navigationView).offset(-15)
        }
        
        selectionTextView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(selectionView).inset(UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        }
        
    }
    
    func selectedLaundryRoom(index: Int, item: String) {
        selectionTextView.text = item
        selectionTextView.textColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        dropDown.hide()
    }
    
    @objc func showDropDown() {
        dropDown.show()
    }
    
    @objc func settingsButtonPressed() {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }

}

