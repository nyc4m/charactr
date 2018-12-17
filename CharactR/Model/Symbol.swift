//
//  File.swift
//  CharactR
//
//  Created by MADELINE ALEXANDRE on 12/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import Foundation

class Symbol {
    private var symbol: String
    private var signification: String
    private var commentary: String
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
    }
    
    init(symbol: String, signification: String, commentary: String){
        self.symbol = symbol
        self.signification = signification
        self.commentary = commentary
    }
    
    func stringify()->String{
        return "Symbol : \(self.symbol), signification : \(self.signification), commentary : \(self.commentary)"
    }
    
    
}
