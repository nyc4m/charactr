//
//  DbGetter.swift
//  CharactR
//
//  Created by MADELINE ALEXANDRE on 12/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import UIKit
import SQLite

class DbGetter{
    
    private static var instance: DbGetter?;
    private var database: Connection!
    private let symbol_table = Table("symbol")
    private let symbol_id = Expression<Int>("id")
    private let symbol_image = Expression<String>("image")
    private let symbol_signification = Expression<String>("signification")
    private let symbol_commentary = Expression<String>("commentary")
    private var table_created:Bool = false
    
    private init(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("symbols").appendingPathExtension("sqlite3")
            let base = try Connection(fileUrl.path)
            self.database = base;
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
            // Instruction pour faire un create de la table USERS
            let createTable = self.symbol_table.create { table in
                table.column(self.symbol_id, primaryKey: .autoincrement)
                table.column(self.symbol_image)
                table.column(self.symbol_signification)
                table.column(self.symbol_commentary)
            }
            do{
                try database.run(createTable)
                self.insertFakeDatas()
            }catch{
                print (error)
            }
        }
        
    }
    
    public func insertFakeDatas(){
        self.insertSymbol(s: Symbol(symbol: "汉语", signification: "qzfqzfqf", commentary: ""))
        self.insertSymbol(s: Symbol(symbol: "Ye", signification: "qzfqzfqf", commentary: ""))
        self.insertSymbol(s: Symbol(symbol: "Ya", signification: "qzfqzfqf", commentary: ""))
        self.insertSymbol(s: Symbol(symbol: "Yi", signification: "qzfqzfqf", commentary: ""))
        print("fake data loaded")
    }
    
    public func reinitTable(){
        if table_created{
            let dropTable = self.symbol_table.drop()
            do{
                try database.run(dropTable)
            }catch{
                print (error)
            }
            self.initTable()
        }else{
            self.initTable()
        }
    }
    
    public func insertSymbol(s: Symbol)->Bool{
        self.initTable()
        let newInsertion = self.symbol_table.insert(symbol_image <- s.Symbol, symbol_signification <- s.Signification, symbol_commentary <- s.Commentary)
        do{
            try database.run(newInsertion);
            print("\(s.stringify()) has been inserted in database")
            return true
        }catch{
            print(error)
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
    
    public func getAllSymbols()->[Symbol]{
        var symbols: [Symbol] = []
        self.initTable()
        do{
            for symbol in try database.prepare(symbol_table) {
                symbols.append(Symbol(id: symbol[symbol_id], symbol: symbol[symbol_image],signification: symbol[symbol_signification],commentary: symbol[symbol_commentary]))
            }
        }catch{
            print (error)
        }
        return symbols
    }
}
