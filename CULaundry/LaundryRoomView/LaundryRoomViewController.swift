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
    
    let laundryRoomName = UILabel()
    
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
        laundryRoomName.textColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1)
        laundryRoomName.font = UIFont(name: "Roboto-Black", size: 35)
        laundryRoomName.textAlignment = .left
        laundryRoomName.adjustsFontSizeToFitWidth = true
        view.addSubview(laundryRoomName)
        
        machineLayout.scrollDirection = .vertical
        machineLayout.minimumLineSpacing = 10
        machineLayout.minimumInteritemSpacing = 10
        machineLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 35, right: 5)
        
        machineCollectionView = UICollectionView(frame: .zero, collectionViewLayout: machineLayout)
        machineCollectionView.allowsSelection = false
        machineCollectionView.backgroundColor = .clear
        machineCollectionView.register(MachineCollectionViewCell.self, forCellWithReuseIdentifier: machineReuseIdentifier)
        machineCollectionView.dataSource = self
        machineCollectionView.delegate = self
        machineCollectionView.register(MachineHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: machineHeaderReuseIdentifier)
        view.addSubview(machineCollectionView)
    }
    
    func setUpConstraints() {
        machineCollectionView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 120, left: 35, bottom: 0, right: 35))
        }
        laundryRoomName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(15)
            make.right.equalTo(machineCollectionView).offset(5)
            make.left.equalTo(machineCollectionView).offset(5)
            make.height.equalTo(50)
        }
    }
    
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
        } else {
            cell.machineName.text = dryers[indexPath.row].machine_name
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
        let size = (machineCollectionView.frame.width - 40) / 4
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: machineCollectionView.frame.width, height: 50)
    }
    
    
}
