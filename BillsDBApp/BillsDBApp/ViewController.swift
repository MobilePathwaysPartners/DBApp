//
//  ViewController.swift
//  BillsDBApp
//
//  Created by Bill Skrzypczak on 2/9/20.
//  Copyright © 2020 Bill Skrzypczak. All rights reserved.
//

// 1. Create a new single view app, give it a name, and be sure to click on the Core Data box below.
//
// 2. Click on the BillsDBApp.xcdatamodeled file in the project file structure. Your may will have the name you named your app.
//
// 3. Click on the Add Entity plus sign at the bottom left of the data model screen.
//
// 4. Now go back up to the Attribute button for the Entity you just created and add an Attribute named "about" of type string.
//
// 5. Now go back and change the name of your Entity to "Item".
//
// 6. Create a UI with two buttons on top, a "saveRecord" button, and a "deleteRecord" button.
//
// 7. Below those buttons add a text field object.
//
// 8. Below the text filed add a image view and popupalte it (optional).
//
// 9. Below your image view add a label object.
//
// 10. Wire up all the object as described in the screen cast.
//
// 11. Import the Foundation Library and the CoreData library to the app.
//
import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    

    // 12. Create the dataManager variable and listArry variable.
    // SCROLL DOWN TO THE viewDidLoad Function TO COMPLETE STEP 13
    //
    var dataManager : NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    // 15. Enter the saveRecordButton function below
    //
    @IBAction func saveRecordButton(_ sender: UIButton) {
        
        let newEntity = NSEntityDescription.insertNewObject(forEntityName:"Item", into: dataManager)
        newEntity.setValue(enterGuitarDescription.text!, forKey: "about")
        
        do{
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch{
            print ("Error saving data")
        }
        displayDataHere.text?.removeAll()
        enterGuitarDescription.text?.removeAll()
        fetchData()
        

        
    }
    
    // 16. Enter the deleteRecordButton function below
    // Yeah! you are done now build and run your code!
    //
    @IBAction func deleteRecordButton(_ sender: UIButton) {
        let deleteItem = enterGuitarDescription.text!
        for item in listArray {
            if item.value(forKey: "about") as! String == deleteItem {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
            } catch {
                print ("Error deleting data")
            }
            displayDataHere.text?.removeAll()
            enterGuitarDescription.text?.removeAll()
            fetchData()
        }
        
    }
    
    
    
    @IBOutlet var enterGuitarDescription: UITextField!
    
    
    
    @IBOutlet var displayDataHere: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 13. Add the constant appDelegate to the viewDidLoad function
        //
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        displayDataHere.text?.removeAll()
        fetchData()
    }
    
    
        // 14. Enter the fetchData function below.
        // GO BACK UP TO THE SAVE RECORD BUTTON FUNCTION TO COMPLETE STEP 15
    func fetchData() {
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                
                let product = item.value(forKey: "about") as! String
                displayDataHere.text! += product

            }
        } catch {
            print ("Error retrieving data")
        }
    }



}

