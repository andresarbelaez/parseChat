//
//  LoginViewController.swift
//  parseChat
//
//  Created by Andrés Arbeláez on 6/21/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    @IBAction func onSignUp(sender: AnyObject) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) in
            if let error = error {
                let errorString = error.userInfo["error"] as?String
                
                let alertController = UIAlertController(title:"Error",  message: errorString, preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title:"OK", style: .Cancel) { (action) in
                    
                }
                
                print(errorString)
                
                alertController.addAction(cancelAction)
                
                self.presentViewController(alertController, animated: true) {
                    
                    
                }
            } else {
                print("loggedIn")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            
        }
        
    }
    
    
    @IBAction func onLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!){ (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil{
                print("logged in!!")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                let errorString = error!.userInfo["error"] as?String
                
                let alertController = UIAlertController(title:"Error",  message: errorString, preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title:"OK", style: .Cancel) { (action) in
                    
                }
                
                print(errorString)
                    
                alertController.addAction(cancelAction)
                
                self.presentViewController(alertController, animated: true) {
                        
                        
                    }
            }
            
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
