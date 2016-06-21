//
//  ChatViewController.swift
//  parseChat
//
//  Created by Andrés Arbeláez on 6/21/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [PFObject]()
    
    @IBAction func onSend(sender: AnyObject) {
        let message = PFObject(className:"Message_fbuJuly2016")
        message["text"] = messageField.text
        message["user"] = PFUser.currentUser()
        
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("The message: \(message["text"]) has been sent")
            } else {
                // There was a problem, check error.description
            }
        }
        
    }
    
    func onTimer() {
        loadData()
        print("Currently reloading data")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
        //NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->  UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as! messageCell
        
        let message = self.messages[indexPath.row]
        
        
        if let messageText = message["text"] {
            let willSetMessage = messageText as! String
            
            
            
            cell.messageLabel!.text! = willSetMessage
            
            
            //print("The message retrieved: \(willSetMessage). The label cell: \(cell.messageLabel!.text!)")
        } else {
            
        }
        
        return cell
    }
    
    
    func loadData(){
        let query = PFQuery(className: "Message_fbuJuly2016")
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) in
            if error == nil {
                
                print("successfully retreived")
                if let objects = objects {
                    self.messages = objects
                    self.tableView.reloadData()
                    //print(self.messages)
                }
            } else {
                print("there was an error")
            }
            
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
