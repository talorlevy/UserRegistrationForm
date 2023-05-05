//
//  UserViewModel.swift
//  UserRegistrationForm
//
//  Created by Talor Levy on 2/19/23.
//

import Foundation

class UserViewModel {
    
    var userList: [User] = []
    
    init() {
        userList = CoreDataManager.shared.fetchUsersFromCoreData()
    }
    
    func addUser(firstName: String, lastName: String, email: String, username: String) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let user = User(context: context)
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.username = username
        user.creationTime = Date()
        userList.append(user)
        CoreDataManager.shared.addUser(user: user)
    }
    
    func deleteUser(user: User) {
        CoreDataManager.shared.deleteUser(user: user)
        if let index = userList.firstIndex(of: user) {
            userList.remove(at: index)
        }
    }
    
    func updateUser(user: User, firstName: String, lastName: String, email: String, username: String, creationTime: Date) {
        CoreDataManager.shared.updateUser(user: user, firstName: firstName, lastName: lastName, email: email, username: username)
        if let index = userList.firstIndex(where: { $0.creationTime == creationTime }) {
            userList[index].firstName = firstName
            userList[index].lastName = lastName
            userList[index].email = email
            userList[index].username = username
        }
    }
}
