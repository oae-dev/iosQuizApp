//
//  DbTables.swift
//  RegisterScreen
//
//  Created by Dev on 25/09/25.
//

import Foundation
import SQLite



class DbTable {
    static let shared = DbTable()
    private var db = DatabaseManager.shared
    
    let users = Table("Users")
    let id = Expression<Int64>("Id")
    let email = Expression<String>("Email")
    let userName = Expression<String>("UserName")
    let password = Expression<String>("Password")
    let DoB = Expression<String>("DOB")
    let Phone = Expression<String>("Phone")
    
    init (){
        let createTableQuery = users.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(email, unique: true)
            t.column(userName)
            t.column(password)
            t.column(DoB)
            t.column(Phone, unique: true)
        }
        
        do {
            try db.db.run(createTableQuery)
        } catch {
            print("Table not created: \(error)")
        }
    }
    
    func AddUser(email:String, userName:String, password:String, DOB:String, phone: String){
        let insertQuerry = users.insert(
            self.email <- email,
            self.userName <- userName,
            self.DoB <- DOB,
            self.password <- password,
            self.Phone <- phone
        )
        do{
            try db.db.run(insertQuerry)
        } catch {
            print("Field to enter new user")
        }
        
    }
    
    func FetchUsers() -> [UsersData] {
        var data:[UsersData] = []
        do {
            let rows = try db.db.prepare(users)
                for row in rows{
                    data.append(UsersData(id: Int(row[id]), email: row[email], userName: row[userName], password: row[password], DOB: row[DoB], Phone: row[Phone]))
                }
            
        } catch {
            print("Data not Collected: \(error)")
        }
        
        return data
    }
}
