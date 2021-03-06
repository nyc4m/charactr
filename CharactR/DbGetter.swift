//
//  DbGetter.swift
//  CharactR
//
//  Created by MADELINE ALEXANDRE on 12/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import UIKit
import SQLite
import CryptoSwift

class DbGetter{
    
    private static var instance: DbGetter?;
    private var database: Connection!
    
    private let symbol_table = Table("symbol")
    private let symbol_id = Expression<Int>("id")
    private let symbol_dictIdFK = Expression<Int>("dictId")
    private let symbol_image = Expression<String>("image")
    private let symbol_signification = Expression<String>("signification")
    private let symbol_commentary = Expression<String>("commentary")
    
    private let user_table = Table("user")
    private let user_id = Expression<Int>("id")
    private let user_name = Expression<String>("username")
    private let user_hash = Expression<String>("passwd_hash")
    private var table_created:Bool = false
    
    private let dict_usr_table = Table("dict_usr_table")
    private let dict_usr_dictId = Expression<Int>("dictId")
    private let dict_usr_usrIdFK = Expression<Int>("userId")
    
    private init(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("symbols").appendingPathExtension("sqlite3")
            let base = try Connection(fileUrl.path)
            self.database = base
            initTable()
        }catch {
            print(error)
        }
    }
    
    public static func getInstance()->DbGetter{
        if instance == nil {
            instance = DbGetter();
        }
        return instance!;
    }
    
    public func initTable(){
        if !table_created{
            
            table_created = true
            self.reinitTable()
            // Instruction pour faire un create de la table USERS
            let createTableSymbol = self.symbol_table.create(ifNotExists: true) { table in
                table.column(self.symbol_id, primaryKey: .autoincrement)
                table.column(self.symbol_image)
                table.column(self.symbol_dictIdFK)
                table.column(self.symbol_signification)
                table.column(self.symbol_commentary)
                
                table.foreignKey(self.symbol_dictIdFK, references: dict_usr_table, self.dict_usr_dictId, delete: .cascade)
            }
            let createTableUser = self.user_table.create(ifNotExists: true){ table in
                table.column(self.user_id, primaryKey: .autoincrement)
                table.column(self.user_name, unique: true)
                table.column(self.user_hash)
            }
            let createDictUsrTable = self.dict_usr_table.create(ifNotExists: true){ table in
                table.column(self.dict_usr_dictId, primaryKey: .autoincrement)
                table.column(self.dict_usr_usrIdFK)
                
                table.foreignKey(self.dict_usr_usrIdFK, references: user_table, self.user_id, delete:.cascade)
            }
            do{
                try database.run(createTableUser)
                try database.run(createDictUsrTable)
                try database.run(createTableSymbol)
                self.insertFakeDatas()
            }catch{
                print (error)
            }
        }
    }
    
    public func insertFakeDatas(){
        self.createUserAccount(username: "Michel", password: "Ziboss")
        self.insertSymbolFor(s: Symbol(symbol: "汉语", signification: "qzfqzfqf", commentary: ""), user: "Michel")
        self.insertSymbolFor(s: Symbol(symbol: "Ye", signification: "qzfqzfqf", commentary: ""), user: "Michel")
        self.insertSymbolFor(s: Symbol(symbol: "Ya", signification: "qzfqzfqf", commentary: ""), user: "Michel")
        self.insertSymbolFor(s: Symbol(symbol: "Yi", signification: "qzfqzfqf", commentary: ""), user: "Michel")
        
        print("fake data loaded")
    }
    
    public func reinitTable(){
        if table_created{
            let dropTable = self.symbol_table.drop()
            let dropUser = self.user_table.drop()
            let dropDict = self.dict_usr_table.drop()
            do{
                try database.run(dropTable)
                try database.run(dropUser)
                try database.run(dropDict)
            }catch{
                print (error)
            }
            self.initTable()
        }else{
            self.initTable()
        }
    }
    
    public func insertSymbolFor(s: Symbol, user: String)->Bool{
        self.initTable()
        let dictId = self.getDictFrom(user: user)
        if dictId != -1{
            let newInsertion = self.symbol_table.insert(symbol_image <- s.Symbol, symbol_signification <- s.Signification, symbol_commentary <- s.Commentary, symbol_dictIdFK <- dictId)
            do{
                try database.run(newInsertion);
                print("\(s.stringify()) has been inserted in database")
                return true
            }catch{
                print(error)
            }
        }
        
        return false
    }
    
    public func removeSymbol(s: Symbol)->Bool{
        if table_created{
            let selectedRow = self.symbol_table.filter(self.symbol_image == s.Symbol && self.symbol_signification == s.Signification && self.symbol_commentary == s.Commentary)
            let remove = selectedRow.delete()
            do{
                try database.run(remove)
                return true
            }catch{
                print (error)
            }
        }
        return false
    }
    public func updateSymbol(s: Symbol)->Bool{
        if(s.Id != -1){
            let symbolToUpdate = symbol_table.filter(self.symbol_id == s.Id);
            do{
                try self.database.run(symbolToUpdate.update(symbol_image <- s.Symbol, symbol_signification <- s.Signification, symbol_commentary <- s.Commentary))
                return true
            }catch {
                print (error)
            }
        }
        return false
    }
    
    public func getAllSymbolsFrom(user: String)->[Symbol]{
        var symbols: [Symbol] = []
        self.initTable()
        let dictId = self.getDictFrom(user: user)
        
        if(dictId != -1){
            let symbolsFromUser = self.symbol_table.filter(symbol_dictIdFK == dictId)
            do{
                for symbol in try database.prepare(symbolsFromUser) {
                    symbols.append(Symbol(id: symbol[symbol_id], symbol: symbol[symbol_image],signification: symbol[symbol_signification],commentary: symbol[symbol_commentary]))
                }
            }catch{
                print (error)
            }
        }
        
        return symbols
    }
    
    public func createUserAccount(username: String, password: String)->Bool{
        let passwdHash = password.sha256()
        let insert = self.user_table.insert(user_name <- username, user_hash <- passwdHash)
        do{
            try self.database.run(insert)
            self.createDict(user: username)
            return true
        }catch{
            print (error)
        }
        return false
        
    }
    
    public func askForConnexion(username: String, password: String) -> Bool{
        let hashpwd = password.sha256();
        let selectUser = user_table.filter(self.user_name == username && user_hash == hashpwd)
        do{
            let existing = try self.database.scalar(selectUser.count)
            if existing == 1 {
                return true
            }
        }catch{
            print (error)
        }
        return false
    }
    
    public func createDict(user: String) -> Int{
        let selectUser = user_table.filter(user_name == user)
        do{
            if userExisting(user: user) {
                for user in try database.prepare(selectUser){
                    let id = user[user_id]
                    let insert = self.dict_usr_table.insert(dict_usr_usrIdFK <- id)
                    try self.database.run(insert)
                }
            }
        }catch{
            print(error)
        }
        return -1
    }
    
    private func getDictFrom(user: String) -> Int{
        if(self.userExisting(user: user)){
            do{
                let dict = user_table.join(self.dict_usr_table, on: dict_usr_usrIdFK == user_id)
                let selectDict = dict.filter(user_name == user)
                for user in try database.prepare(selectDict){
                    let id = user[self.dict_usr_dictId]
                    return id
                }
            }catch{
                print(error)
            }
        }
        return -1
    }
    
    private func userExisting(user: String) -> Bool{
        let user = self.user_table.filter(user_name == user)
        do{
            if(try self.database.scalar(user.count) == 1){
                return true
            }
        }catch{
            print(error)
        }
        return false
    }
}
