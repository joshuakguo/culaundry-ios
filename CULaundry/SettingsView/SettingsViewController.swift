//
//  SettingsViewController.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/1/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let sectionSeparatorHeight: CGFloat = 40
    
    let settingsTableView = UITableView(frame: CGRect(), style: .grouped)
    let settingsReuseIdentifier = "settingsReuseIdentifier"
    let settingsData = [["Created for the AppDev SP21 Hack Challenge by Connor Chen (cjc353), Joshua Guo (jcg294), and Michelle Sun (mss455).", "iOS Frontend Github Repo", "Backend Github Repo"], ["There should be settings here but there's nothing for you to change.", "Why are you reading this?"]]
    let settingsHeaderData = ["ABOUT US", "SETTINGS"]
    
    let settingsURLArray = ["https://github.com/joshuakguo/culaundry-ios", "https://github.com/connorjchen/culaundry-backend"]
    
    let headerReuseIdentifier = "headerReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        
        setUpViews()
        setUpConstraints()
        
    }
    
    func setUpViews() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(red: 93/255, green: 117/255, blue: 1, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font : UIFont.boldSystemFont(ofSize: 14)]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.backButtonTitle = "Settings"
        self.navigationController?.navigationBar.tintColor = .white
        
        settingsTableView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        settingsTableView.rowHeight = UITableView.automaticDimension
        settingsTableView.estimatedRowHeight = UITableView.automaticDimension
        settingsTableView.sectionHeaderHeight = sectionSeparatorHeight
        
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: settingsReuseIdentifier)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(SettingsTableHeaderView.self, forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
        settingsTableView.tableFooterView = UIView()
        view.addSubview(settingsTableView)
        
    }
    
    func setUpConstraints() {
        settingsTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 2) {
            let urlString = self.settingsURLArray[indexPath.row - 1]
            if let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
            }
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingsReuseIdentifier, for: indexPath) as! SettingsTableViewCell
        cell.configure(with: settingsData[indexPath.section][indexPath.row])
        if indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 2) {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseIdentifier) as! SettingsTableHeaderView
        header.configure(headerText: settingsHeaderData[section])
        return header
    }
}
