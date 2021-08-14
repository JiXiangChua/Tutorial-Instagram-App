//
//  SettingsViewController.swift
//  Instagram
//
//  Created by JI XIANG on 8/8/21.
//

import SafariServices
import UIKit

struct SettingCellModel {
    //Each cell model should have a title and a handler that takes in no parameter and returns void
    let title: String
    let handler: (()-> Void)
}

/// View Controller to show user settings
final class SettingsViewController: UIViewController { //the final means no other class can subclass this class.
    
    //Creating a tableViewController inside this viewController
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped) //.grouped gives the  default look of that groups table view section
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") //register the cell with cellID = "cell"
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView) //adding the tableView as subview
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewDidLayoutSubviews() { //this function gets called after all the other subviews have laid out so that we can assign our frames in here. That way we can account for things like safearea...
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        //First Section
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in //the [weak self] ensures we dont cause a memory leak because we're referencing self.
                self?.didTapEditProfile()
                
            },
            SettingCellModel(title: "Invite Friends") { [weak self] in //the [weak self] ensures we dont cause a memory leak because we're referencing self.
                self?.didTapInviteFriends()
            },
            SettingCellModel(title: "Save Original Posts") { [weak self] in //the [weak self] ensures we dont cause a memory leak because we're referencing self.
                self?.didTapSaveOriginalPost()
            }
        ])
        //Second Section
        data.append([
            SettingCellModel(title: "Terms of Service") { [weak self] in //the [weak self] ensures we dont cause a memory leak because we're referencing self.
                self?.openURL(type: .terms)
            },
            SettingCellModel(title: "Privacy Policy") { [weak self] in //the [weak self] ensures we dont cause a memory leak because we're referencing self.
                self?.openURL(type: .privacy)
            },
            SettingCellModel(title: "Help / Feedback") { [weak self] in //the [weak self] ensures we dont cause a memory leak because we're referencing self.
                self?.openURL(type: .help)
            }
        ])
        //Third Section
        data.append([
            SettingCellModel(title: "Log Out") { [weak self] in //the [weak self] ensures we dont cause a memory leak because we're referencing self.
                self?.didTapLogOut()
            }
        ])
    }
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        
        switch type {
        case .terms: urlString = "https://help.instagram.com/581066165581870"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com"
            
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapSaveOriginalPost() {
        
    }
    
    private func didTapInviteFriends() {
        //Show share sheet to invite friends
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func didTapLogOut() {
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //destructive is a red color button
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            //if user pressed log out, then the below function will be executed under the handler function.
            AuthManager.shared.logOut { success in
                DispatchQueue.main.async {
                    if success {
                        //Present log in view controller
                        //Show log in
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true, completion: { //upon completion of presenting, we should get rid of the settings and switch back to the main tab that way when the user logs in again they're back on the home tab rather than on settings!
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                            
                        })
                    } else {
                        //Error occured
                        fatalError("Could not log out user")
                    }
                }
            }
            
        }))
        
        //To avoid crashing on iPads, so that the actionsheet knows how to present itself on iPad
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        //Present the action sheet
        present(actionSheet, animated: true)
        
    }
    
    
    
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { //how many sections in this tableView
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //return the number of rows
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Handle cell selected
        let model = data[indexPath.section][indexPath.row]
        model.handler() //involve the model function which has a log out function
    }
}
