//
//  ViewController.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/7/21.
//

import UIKit

class LaundryRoomViewController: UIViewController {
    
    var hallID: String = ""
    var laundryRoom: LaundryRoomLong?
    var washers: [LaundryMachine] = []
    var dryers: [LaundryMachine] = []
    
    weak var delegate: LaundryRoomDelegate?
    
    let laundryRoomBackground = UIView()
    let laundryRoomName = UILabel()
    let dragDown = UIImageView()
    
    let machineLayout = UICollectionViewFlowLayout()
    var machineCollectionView: UICollectionView!
    let machineReuseIdentifier = "machineReuseIdentifier"
    let machineHeaderReuseIdentifier = "machineHeaderReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)

        setUpData()
        setUpViews()
        setUpConstraints()
    }
    
    func setUpData() {
        NetworkManager.getHall(id: hallID) { laundryRoomLong in
            self.laundryRoom = laundryRoomLong
            for machine in laundryRoomLong.machines {
                if machine.isWasher == 1 {
                    self.washers.append(machine)
                } else if machine.isWasher == 0 {
                    self.dryers.append(machine)
                }
            }
            self.washers.sort { laundryMachine1, laundryMachine2 in
                laundryMachine1.machine_name < laundryMachine2.machine_name
            }
            self.dryers.sort { laundryMachine1, laundryMachine2 in
                laundryMachine1.machine_name < laundryMachine2.machine_name
            }
            self.machineCollectionView.reloadData()
        }
    }
    
    func setUpViews() {
        laundryRoomBackground.backgroundColor = UIColor(red: 93/255, green: 117/255, blue: 1, alpha: 1)
        view.addSubview(laundryRoomBackground)
        
        laundryRoomName.textColor = .white
        laundryRoomName.font = UIFont.boldSystemFont(ofSize: 35)
        laundryRoomName.textAlignment = .left
        laundryRoomName.adjustsFontSizeToFitWidth = true
        view.addSubview(laundryRoomName)
        
        dragDown.image = UIImage(systemName: "chevron.compact.down")
        dragDown.tintColor = .white
        view.addSubview(dragDown)
        
        machineLayout.scrollDirection = .vertical
        machineLayout.minimumLineSpacing = 10
        machineLayout.minimumInteritemSpacing = 10
        machineLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0)
        
        machineCollectionView = UICollectionView(frame: .zero, collectionViewLayout: machineLayout)
        machineCollectionView.allowsSelection = true
        machineCollectionView.allowsMultipleSelection = false
        machineCollectionView.backgroundColor = .clear
        machineCollectionView.register(MachineCollectionViewCell.self, forCellWithReuseIdentifier: machineReuseIdentifier)
        machineCollectionView.dataSource = self
        machineCollectionView.delegate = self
        machineCollectionView.register(MachineHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: machineHeaderReuseIdentifier)
        view.addSubview(machineCollectionView)
    }
    
    func setUpConstraints() {
        machineCollectionView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 170, left: 30, bottom: 0, right: 30))
        }
        laundryRoomBackground.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(150)
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        laundryRoomName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(90)
            make.right.equalTo(machineCollectionView)
            make.left.equalTo(machineCollectionView).offset(5)
            make.height.equalTo(50)
        }
        dragDown.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    }
    
}

extension LaundryRoomViewController: UICollectionViewDelegate {
}

extension LaundryRoomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return washers.count
        } else {
            return dryers.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: machineReuseIdentifier, for: indexPath) as! MachineCollectionViewCell
        if indexPath.section == 0 {
            cell.machineName.text = washers[indexPath.row].machine_name
            cell.timeRemainingInt = washers[indexPath.row].timeLeft
            cell.isAvailable = washers[indexPath.row].isAvailable
            cell.isOOS = washers[indexPath.row].isOOS
            cell.isOffline = washers[indexPath.row].isOffline
            cell.isWasher = 1
            if cell.isAvailable == 0 && cell.isOOS == 0 && cell.isOffline == 0 {
                cell.timeRemaining.text = String(cell.timeRemainingInt) + " min"
                cell.machineName.text?.append(" - In Use")
            } else if cell.isAvailable == 1 && cell.isOOS == 0 && cell.isOffline == 0 {
                cell.timeRemaining.text = "Available"
                cell.machineName.text?.append(" - Open")
            } else if cell.isOOS == 1 && cell.isOffline == 0 {
                cell.timeRemaining.text = "Out of Service"
                cell.machineName.text?.append(" - OOS")
            } else if cell.isOffline == 1 && cell.isOOS == 0 {
                cell.timeRemaining.text = "Offline"
                cell.machineName.text?.append(" - Offline")
            }
            if cell.isAvailable == 1 && cell.isOOS == 0 && cell.isOffline == 0 {
                cell.machine.image = UIImage(named: "Washer2Green")
            } else if cell.isOOS == 1 || cell.isOffline == 1 {
                cell.machine.image = UIImage(named: "Washer2")
            } else {
                cell.machine.image = UIImage(named: "Washer2Red")
            }
        } else {
            cell.machineName.text = dryers[indexPath.row].machine_name
            cell.timeRemainingInt = dryers[indexPath.row].timeLeft
            cell.isAvailable = dryers[indexPath.row].isAvailable
            cell.isOOS = dryers[indexPath.row].isOOS
            cell.isOffline = dryers[indexPath.row].isOffline
            cell.isWasher = 0
            if cell.isAvailable == 0 && cell.isOOS == 0 && cell.isOffline == 0 {
                cell.timeRemaining.text = String(cell.timeRemainingInt) + " min"
                cell.machineName.text?.append(" - In Use")
            } else if cell.isAvailable == 1 && cell.isOOS == 0 && cell.isOffline == 0 {
                cell.timeRemaining.text = "Available"
                cell.machineName.text?.append(" - Open")
            } else if cell.isOOS == 1 && cell.isOffline == 0 {
                cell.timeRemaining.text = "Out of Service"
                cell.machineName.text?.append(" - OOS")
            } else if cell.isOffline == 1 && cell.isOOS == 0 {
                cell.timeRemaining.text = "Offline"
                cell.machineName.text?.append(" - Offline")
            }
            if cell.isAvailable == 1 && cell.isOOS == 0 && cell.isOffline == 0 {
                cell.machine.image = UIImage(named: "Dryer2Green")
            } else if cell.isOOS == 1 || cell.isOffline == 1 {
                cell.machine.image = UIImage(named: "Dryer2")
            } else {
                cell.machine.image = UIImage(named: "Dryer2Red")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: machineHeaderReuseIdentifier, for: indexPath) as! MachineHeaderView
        if indexPath.section == 0 {
            header.label.text = "Washers"
        } else if indexPath.section == 1 {
            header.label.text = "Dryers"
        }
        return header
    }
}

extension LaundryRoomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (machineCollectionView.frame.width - 10) / 2
        return CGSize(width: size, height: (size / 2) + 15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: machineCollectionView.frame.width, height: 50)
    }
    
    
}
