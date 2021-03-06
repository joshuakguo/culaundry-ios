//
//  ViewController.swift
//  CULaundry
//
//  Created by Joshua Guo on 4/30/21.
//

import UIKit
import SnapKit
import DropDown

protocol LaundryRoomDelegate: AnyObject {
    func setLaundryRoom(laundryRoom: LaundryRoomLong)
}

class ViewController: UIViewController {
    
    let laundryRoomList = ["Akwe:kon", "Balch Hall North", "Balch Hall South", "Bauer Hall", "Latino Living Center", "Clara Dickson Hall", "Mary Donlon Hall", "George Jameson Hall", "High Rise 5", "Ecology House", "Kay Hall", "Ujamaa", "Low Rise 6", "Low Rise 7", "HILC", "Just About Music", "Mews Hall A", "Mews Hall B", "Risley Hall", "Townhouse CC", "Townhouse E", "Townhouse G"]
    
    let headers = ["North Campus"]
    
    let settingsButton = UIBarButtonItem()
    let navigationView = UIView()
    let titleView = UILabel()
    let selectionView = UIView()
    let selectionTextView = UILabel()
    let dropDown = DropDown()
    
    let laundryRoomViewLayout = UICollectionViewFlowLayout()
    var laundryRoomView: UICollectionView!
    let laundryRoomViewReuseIdentifier = "laundryRoomViewReuseIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifier"
    
    var allLaundryRoomData: [[LaundryRoomShort]] = [[]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        initData()
        setUpViews()
        setUpConstraints()
    }
    
    func initData() {
        NetworkManager.getAllHalls { post in
            self.allLaundryRoomData = [post]
            self.laundryRoomView.reloadData()
        }
    }
        
    func setUpViews() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(red: 93/255, green: 117/255, blue: 1, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font : UIFont.boldSystemFont(ofSize: 14)]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.backButtonTitle = "Back"
        
        navigationItem.rightBarButtonItem = settingsButton
        settingsButton.image = UIImage(systemName: "gearshape.fill")
        settingsButton.tintColor = .white
        settingsButton.action = #selector(settingsButtonPressed)
        settingsButton.target = self
        
        navigationView.backgroundColor = UIColor(red: 93/255, green: 117/255, blue: 1, alpha: 1)
        view.addSubview(navigationView)
        
        titleView.textColor = .white
        titleView.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        titleView.text = "Laundry Rooms"
        titleView.textAlignment = .left
        view.addSubview(titleView)
        
        selectionView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        selectionView.layer.cornerRadius = 8
        view.addSubview(selectionView)
        
        selectionTextView.textColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        selectionTextView.font = UIFont.systemFont(ofSize: 16)
        selectionTextView.text = "Select a Laundry Room"
        selectionTextView.textAlignment = .left
        selectionTextView.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(showDropDown))
        selectionTextView.addGestureRecognizer(labelTapGesture)
        view.addSubview(selectionTextView)
        
        dropDown.anchorView = selectionTextView
        dropDown.dataSource = laundryRoomList
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            NetworkManager.updateAllMachines { bool in
            }
            initData()
            wait()
            let vc = LaundryRoomViewController()
            vc.laundryRoomName.text = allLaundryRoomData[0][index].name
            vc.hallID = allLaundryRoomData[0][index].lv_id
            present(vc, animated: true)
        }
        dropDown.dismissMode = .automatic
        DropDown.appearance().textColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        DropDown.appearance().selectedTextColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        laundryRoomViewLayout.scrollDirection = .vertical
        laundryRoomViewLayout.minimumLineSpacing = 15
        laundryRoomViewLayout.minimumInteritemSpacing = 15
        laundryRoomViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        laundryRoomView = UICollectionView(frame: .zero, collectionViewLayout: laundryRoomViewLayout)
        laundryRoomView.allowsSelection = true
        laundryRoomView.backgroundColor = .clear
        laundryRoomView.register(LaundryRoomCollectionViewCell.self, forCellWithReuseIdentifier: laundryRoomViewReuseIdentifier)
        laundryRoomView.dataSource = self
        laundryRoomView.delegate = self
        laundryRoomView.register(LaundryRoomHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        view.addSubview(laundryRoomView)
        
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
        
        laundryRoomView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(navigationView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
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

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NetworkManager.updateAllMachines { bool in
        }
        initData()
        wait()
        let vc = LaundryRoomViewController()
//        set the info here
        vc.laundryRoomName.text = allLaundryRoomData[indexPath.section][indexPath.row].name
        vc.hallID = allLaundryRoomData[indexPath.section][indexPath.row].lv_id
        present(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (laundryRoomView.frame.width - 35) / 2
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: laundryRoomView.frame.width, height: 48)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allLaundryRoomData[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allLaundryRoomData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: laundryRoomViewReuseIdentifier, for: indexPath) as! LaundryRoomCollectionViewCell
        cell.configure(image: (UIImage(named: allLaundryRoomData[indexPath.section][indexPath.row].name) ?? UIImage(named: "Court Hall"))!, text: allLaundryRoomData[indexPath.section][indexPath.row].name )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! LaundryRoomHeaderView
        header.label.text = headers[indexPath.section]
        return header
    }
    
}
