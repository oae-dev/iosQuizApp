//
//  CoreDataManager.swift
//  RegisterScreen
//
//  Created by Dev on 30/09/25.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentContainer(name: "UsersInfo")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Load Error: \(error)")
            } else {
                print("Core Data Load Successfully")
                if let url = description.url {
                    print("Core Data SQLite file location: \(url)")
                }
            }
        }
        context = container.viewContext
    }
    
    func saveContext() {
            do {
                try context.save()
                print("Data saved successfully")
            } catch {
                print("Failed to save data: \(error.localizedDescription)")
            }
    }
    
    func saveUser(userdata: UsersData) {
        let newUser = UsersInfo(context: context)
        newUser.email = userdata.email
        newUser.userName = userdata.userName
        newUser.password = userdata.password
        newUser.dob = userdata.DOB
        newUser.phoneNumber = userdata.Phone
        
        saveContext()
    }
    
    func fetchUsers() -> [UsersInfo] {
        let request: NSFetchRequest<UsersInfo> = UsersInfo.fetchRequest()
        do {
            print(request)
            return try context.fetch(request)
            
        } catch {
            print("Fetch users failed: \(error.localizedDescription)")
            return []
        }
    }
}
