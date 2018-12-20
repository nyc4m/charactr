//
//  File.swift
//  CharactR
//
//  Created by MADELINE ALEXANDRE on 12/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import Foundation

class Symbol {
    
    private let id: Int
    private var symbol: String
    private var signification: String
    private var commentary: String
    
    var Id: Int {
        get {
            return id
        }
    }
    
    var Symbol: String {
        get{
            return symbol
        }
    }
    var Signification: String{
        get{
            return signification
        }
    }
    var Commentary: String{
        get{
            return commentary
        }
    }
    
    init(){
        self.symbol = "NO_SYMBOL_PATH"
        self.signification = "NO_SIGNIFICATION"
        self.commentary = "NO_COMMENTARY"
        id = -1
    }
    
    init(id: Int, symbol: String, signification: String, commentary: String){
        self.id = id
        self.symbol = symbol
        self.signification = signification
        self.commentary = commentary
    }
    
    init(symbol: String, signification: String, commentary: String){
        self.id = -1
        self.symbol = symbol
        self.signification = signification
        self.commentary = commentary
    }
    
    func stringify()->String{
        return "Symbol (id: \(self.id)) is \(self.symbol), signification : \(self.signification), commentary : \(self.commentary)"
    }
    
    
}
