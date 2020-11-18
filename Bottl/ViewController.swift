//
//  ViewController.swift
//  Bottl
//
//  Created by charlie on 11/11/20.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var msgOut: UILabel!
    
    @IBOutlet weak var dateTimeOut: UILabel!
    
    @IBOutlet var ScreenA: UIView!
    
    @IBOutlet weak var MessageOutText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func RefreshMessage(_ sender: Any) {
    }
    
    @IBAction func returnHome(unwindSegue: UIStoryboardSegue) {
        
    }
    
    func betterPrintGenericInfo<T>(_ value: T) {
        let t = type(of: value as Any)
        print("'\(value)' of type '\(t)'")
    }


   
    
    
    @IBAction func getMessage(_ sender: Any){

            db.collection("messages").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    }
                    else{
                        let data = self.duplicateRemover(querySnapshot: querySnapshot!)

                        self.updateMessageOutputs(data: data)
                    }
        }
    }
    
    
    func duplicateRemover(querySnapshot : QuerySnapshot) -> QueryDocumentSnapshot{
        
        var data = querySnapshot.documents.randomElement()!
        while (!self.isDuplicate(data: data)){
            data = querySnapshot.documents.randomElement()!
        }
        
        return data
    }
    
    func isDuplicate(data : QueryDocumentSnapshot) -> Bool {
        return ((data.get("content") as? String) != msgOut.text)
    }
    
    
    func updateMessageOutputs(data : QueryDocumentSnapshot){
        self.msgOut.text = data.get("content") as? String
        self.dateTimeOut.text = (data.get("date") as? String ?? "Unknown Date") + " - " + (data.get("time") as? String ?? "Unknown Time")

    }
    
    
    
}

