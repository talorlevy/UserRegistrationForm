//
//  ViewController.swift
//  iOSTechnicalAssessment
//
//  Created by Talor Levy on 2/16/23.
//

import UIKit
import CoreData

class ListViewController: UIViewController {

    // MARK: - @IBOutlet

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var userTableView: UITableView!
    
    var userViewModel: UserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel = UserViewModel()
    }
    
    // MARK: - @IBAction

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            userViewModel?.userList = userViewModel?.userList.sorted(by: { $0.creationTime ?? Date() < $1.creationTime ?? Date() }) ?? []
        case 1:
            userViewModel?.userList = userViewModel?.userList.sorted(by: { ($0.firstName?.lowercased() ?? "") < ($1.firstName?.lowercased() ?? "") }) ?? []
        default:
            break
        }
        userTableView.reloadData()
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        guard let addVC = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else { return }
        addVC.delegate = self
        self.navigationController?.pushViewController(addVC, animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userViewModel?.userList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") else { return UITableViewCell() }
        let user = userViewModel?.userList[indexPath.row]
        cell.textLabel?.text = (user?.firstName ?? "") + " " + (user?.lastName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Update", style: .default, handler: { (action) in
            let user = self.userViewModel?.userList[indexPath.row]
            guard let updateVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as? UpdateViewController else { return }
            updateVC.user = user ?? User()
            updateVC.delegate = self
            self.navigationController?.pushViewController(updateVC, animated: true)}))
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) in
            let user = self.userViewModel?.userList[indexPath.row]
            self.userViewModel?.deleteUser(user: user ?? User())
            self.userTableView.reloadData()}))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
}


// MARK: - SendNewUser

extension ListViewController: SendNewUser {
    func sendNewUser(firstName: String, lastName: String, email: String, username: String) {
        userViewModel?.addUser(firstName: firstName, lastName: lastName, email: email, username: username)
        userTableView.reloadData()
    }
}


// MARK: - SendUpdatedUser

extension ListViewController: SendUpdatedUser {
    func sendUpdatedUser(user: User, firstName: String, lastName: String, email: String, username: String, creationTime: Date) {
        userViewModel?.updateUser(user: user, firstName: firstName, lastName: lastName, email: email, username: username, creationTime: creationTime)
        userTableView.reloadData()
    }
}
