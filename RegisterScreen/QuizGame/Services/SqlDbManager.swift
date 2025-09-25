//
//  SqlDbManager.swift
//  RegisterScreen
//
//  Created by Dev on 25/09/25.
//

import Foundation
import SQLite

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    let db: Connection
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        db = try! Connection("\(path)/userData.db")
    }
    
    
}
