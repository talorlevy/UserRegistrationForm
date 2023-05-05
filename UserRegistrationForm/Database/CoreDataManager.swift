//
//  CoreDataManager.swift
//  UserRegistrationForm
//
//  Created by Talor Levy on 2/18/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserRegistrationForm")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Persistent container failure: \(error)")
            }
        })
        return container
    }()
    
    func fetchUsersFromCoreData() -> ([User]) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error
                fatalError("Save context failure: \(error)")
            }
        }
    }
    
    func addUser(user: User) {
        let context = persistentContainer.viewContext
        CoreDataManager.shared.saveContext(context: context)
    }
    
    func deleteUser(user: User) {
        persistentContainer.viewContext.delete(user)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed: \(error)")
        }
    }
    
    func updateUser(user: User, firstName: String, lastName: String, email: String, username: String) {
        let context = persistentContainer.viewContext
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.username = username
        saveContext(context: context)
    }
}
