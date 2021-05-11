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

//let hallidDictionary =
//    ["Akwe:kon": "1638342",
//     "Balch Hall North": "1638314",
//     "Balch Hall South": "1638330",
//"Bauer Hall", "1638358",
//"Latino Living Center", "163833",
//"Clara Dickson Hall", "1638321",
//"Mary Donlon Hall", "1638322",
//"George Jameson Hall", "1638324",
//"High Rise 5", "1638325",
//"Ecology House", "1638317",
//"Kay Hall", "lv_id": "1638359",
//"Ujamaa", "lv_id": "163837",
//"Low Rise 6", "lv_id": "1638326",
//"Low Rise 7", "lv_id": "1638312",
//"HILC", "lv_id": "1638327",
//"Just About Music", "lv_id": "1638310",
//"Mews Hall A", "lv_id": "1638356",
//"Mews Hall B", "lv_id": "1638357",
//"Risley Hall", "lv_id": "1638328",
//"Townhouse CC", "lv_id": "1638320",
//"Townhouse E", "lv_id": "1638331",
//"Townhouse G", "lv_id": "1638332"]

class ViewController: UIViewController {
    
    private let cornellRed: UIColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
    
    let fakeLaundryRooms = ["Balch Hall", "Bauer Hall", "Clara Dickson Hall", "Court Hall", "George Jameson Hall", "Mary Donlon Hall", "Cook House", "Bethe House"]
    
    let headers = ["North Campus"]
    let fakeSectionedLaundryRooms = [["Balch Hall", "Bauer Hall", "Clara Dickson Hall", "Court Hall", "George Jameson Hall", "Mary Donlon Hall"], ["Cook House", "Bethe House"]]
    
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
//        createDummyData()
        setUpViews()
        setUpConstraints()
    }
    
    //REFRESH FUNCTION UPDATE MACHINES, UPDATE HALLS, GET ALL HALLS
    
    func initData() {
//        NetworkManager.updateAllMachines { post in
//            print("ok")
//        }
//        NetworkManager.updateAllHalls { post in
//            print("ok")
//        }
        NetworkManager.getAllHalls { post in
            self.allLaundryRoomData = [post]
            self.laundryRoomView.reloadData()
        }
        //UPDATE HALLS, GET ALL HALLS TO POPULATE allLaundryRoomData
    }
    
    func createDummyData() {
        let Hall1 = LaundryRoomShort(name: "Balch Hall", lv_id: "1", num_avail_wash: 3, num_avail_dry: 4)
        let Hall2 = LaundryRoomShort(name: "Bauer Hall", lv_id: "2", num_avail_wash: 4, num_avail_dry: 3)
        let Hall3 = LaundryRoomShort(name: "Clara Dickson Hall", lv_id: "3", num_avail_wash: 5, num_avail_dry: 8)
        let Hall4 = LaundryRoomShort(name: "Court Hall", lv_id: "4", num_avail_wash: 2, num_avail_dry: 1)
        let Hall5 = LaundryRoomShort(name: "George Jameson Hall", lv_id: "5", num_avail_wash: 4, num_avail_dry: 4)
        let Hall6 = LaundryRoomShort(name: "Mary Donlon Hall", lv_id: "6", num_avail_wash: 10, num_avail_dry: 9)
        let Hall7 = LaundryRoomShort(name: "Kay Hall", lv_id: "7", num_avail_wash: 2, num_avail_dry: 1)
        allLaundryRoomData = [[Hall1, Hall2, Hall3, Hall4, Hall5, Hall6, Hall7]]
        
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
        
        selectionView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
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
        //TODO HAVE TO UPDATE THIS LINE HERE BC ITS NOT RIGHT
        dropDown.dataSource = fakeLaundryRooms
        dropDown.dismissMode = .automatic
        DropDown.appearance().textColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        DropDown.appearance().selectedTextColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            selectedLaundryRoom(index: index, item: item)
        }
        
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
//        indexpath tell us what the name of the selected laundry room is
//        then use a dictionary to get from the name to the id for the GET request
//        then use the GET request for indiv laundry rooms
//        set the info in the created LaundryRoomVC then present it
        let vc = LaundryRoomViewController()
//        set the info here
        vc.laundryRoomName.text = allLaundryRoomData[indexPath.section][indexPath.row].name
        vc.hallID = allLaundryRoomData[indexPath.section][indexPath.row].lv_id
        present(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (laundryRoomView.frame.width - 45) / 2
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
        //Cell Configure statement
        cell.configure(image: (UIImage(named: allLaundryRoomData[indexPath.section][indexPath.row].name) ?? UIImage(named: "Court Hall"))!, text: allLaundryRoomData[indexPath.section][indexPath.row].name )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! LaundryRoomHeaderView
        header.label.text = headers[indexPath.section]
        return header
    }
    
}
