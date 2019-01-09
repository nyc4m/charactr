//
//  CharCell.swift
//  CharactR
//
//  Created by PRUNOT BAPTISTE on 18/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import UIKit

class CharCell: UITableViewCell {

    

    @IBOutlet weak var labelSymbol: UILabel!
    @IBOutlet weak var labelMeaning: UILabel!
    var idx: Int!
    var controller: CharTable?;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func deleteCell(_ sender: Any) {
        controller?.deleteCell(cell: self)
    }
}
