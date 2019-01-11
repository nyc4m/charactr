//
//  CharTable.swift
//  CharactR
//
//  Created by PRUNOT BAPTISTE on 18/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import UIKit






class CharTable: UITableViewController {
    
    var DATAS: [Symbol] = []
    private let cell_identifier = "char_cell"
    
    private var selected: Symbol?
    
    private func loadData() {
        DATAS = DbGetter.getInstance().getAllSymbolsFrom(user: "Michel")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? DetailSymbolViewController else {
            fatalError("couldn't cast in correct type")
        }
        controller.id = selected?.Id
        controller.signification = selected?.Signification
        controller.symbol = selected?.Symbol
        controller.commentary = selected?.Commentary
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = DATAS[indexPath.row]
        print(selected!.Id)
        performSegue(withIdentifier: "char_cell_to_details", sender: self)
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DATAS.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Transtypage pour avoir la classe définie dans le projet (CharCell) et si ça marche pas -> erreur
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell_identifier, for: indexPath) as? CharCell else {
            fatalError("Could not cast into CharCell")
        }
        
        let char = DATAS[indexPath.row]
        cell.idx = indexPath.row
        cell.controller = self
        cell.labelSymbol.text = char.Symbol
        cell.labelMeaning.text = char.Signification
        
        return cell
    }
    
    //Utilisé pour redimensionné la hauteur d'une ligne, parce que depuis le storyboard ça marche pas
    //90 c'est arbitraire, c'est juste pour afficher les deux labels
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func deleteCell(cell : CharCell) {
        if DbGetter.getInstance().removeSymbol(s: self.DATAS[cell.idx]){
            self.DATAS = DbGetter.getInstance().getAllSymbolsFrom(user:"Michel")
            self.tableView.reloadData()
        }
    }
    
}
