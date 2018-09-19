//
//  ViewController.swift
//  MessyApp
//
//  Created by Petre Vane on 15/09/2018.
//  Copyright © 2018 OrbSec. All rights reserved.


import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    // Declare instance variables here
    var messageArray: [Message] = [Message]()
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //TODO: Set yourself as the delegate of the text field here:

        messageTextfield.delegate = self
        
        //TODO: Set the tapGesture here:
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)

        //TODO: Register your MessageCell.xib file here:
        
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        retreiveMessages()

    }

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
   
    
    //TODO: Declare cellForRowAtIndexPath here:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
     
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage.init(named: "vultur")
        cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
        cell.messageBody.textColor = UIColor.flatWhite()
        
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email as! String! {
            
            cell.messageBackground.backgroundColor = UIColor.flatPurple()
            cell.messageBody.textColor = UIColor.flatWhite()
            cell.avatarImageView.image = UIImage.init(named: "cutu")
            
        }
        
        return cell
    }
    
    //TODO: Declare numberOfRowsInSection here:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
    }
    
    
    //TODO: Declare tableViewTapped here:
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
        
    }
    
    //TODO: Declare configureTableView here:
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        UIView.animate(withDuration: 0.3) {
            
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
        
    }
    
    //TODO: Declare textFieldDidEndEditing here:
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.3) {
            
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
        
    }
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        
        //TODO: Send the message to Firebase and save it in our database
        // Collapsing the text field back to bottom;
        //messageTextfield.endEditing(true)
        // Disable sending extra messages, while one message is on the way to the database
        
        sendButton.isEnabled = false
        
        // Creating a Firebase database, where the messages should be stored
        
        let messagesDB = Database.database().reference().child("Messages")
        
        // Saving the messages as Dictionary
        
        let messageSent = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextfield.text!]
        
        // Identify each message saved to your database, by referencing each messageSent
        messagesDB.childByAutoId().setValue(messageSent) { (error, reference) in
            
            if error != nil {
                
                print (error!)
    
            } else {
                
                print ("Message saved")
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
            
        }
        
    }
    
    //TODO: Create the retrieveMessages method here:
    
    func retreiveMessages () {
        
        let messagesDB = Database.database().reference().child("Messages")
        
        messagesDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let messageText = snapshotValue["MessageBody"]!
            let messageSender = snapshotValue["Sender"]!
            
            //print(messageText, messageSender)
            
            let messagesObject = Message()
            messagesObject.messageBody = messageText
            messagesObject.sender = messageSender
            
            self.messageArray.append(messagesObject)
            self.configureTableView()
            self.messageTableView.reloadData()
            
        }
        
    }

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        
        
        do {
            try Auth.auth().signOut()
            // dismissing the segue will not work
            //dismiss(animated: true, completion: nil)
            
            // there is another function that takes the user back to the root ViewController
            navigationController?.popToRootViewController(animated: true)
         
        } catch  {
            print("there was an error signing out")
        }


    }

}
