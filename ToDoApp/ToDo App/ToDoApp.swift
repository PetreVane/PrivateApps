//
//  ToDoApp.swift
//  ToDo App
//
//  Created by Petre Vane on 29/09/2018.
//  Copyright © 2018 Petre Vane. All rights reserved.
//

import UIKit

class ToDoApp: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    let firstSection = ["Cell 1 Section 1", "Cell 2 Section 1", "Cell 3 Section 1"]
    let secondSection = ["Cell 1 Section 2", "Cell 2 Section 2", "Cell 3 Section 2"]
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        switch section {
        case 0:
            return firstSection.count
        case 1:
            return secondSection.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Section 1"
        case 1:
            return "Section 2"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        switch indexPath.section {
            case 0:
                 cell.textLabel?.text = firstSection[indexPath.row]
            case 1:
                 cell.textLabel?.text = secondSection[indexPath.row]
            default:
                 cell.textLabel?.text = "You should not be here"
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // print("You've selected cell \(indexPath.row) in section \(indexPath.section) ")
        
//        switch indexPath.section {
//        case 0:
//            print("Your content is: \(firstSection[indexPath.row])")
//        case 1:
//            print("Your content is: \(secondSection[indexPath.row])")
//        default:
//            print("You should be somewhere else")
//        }
      // flashing the selected cell
        
        tableView.deselectRow(at: indexPath, animated: true)
    
    // Adding a checkmark for the selected cell
        
    // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
       
    // Checking to see if the selected cell already has a checkmark
        if tableView.cellForRow(at: indexPath)!.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
      
    }
    
   
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
