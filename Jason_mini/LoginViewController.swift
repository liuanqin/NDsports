//
//  LoginViewController.swift
//  Jason_mini
//
//  Created by Anqing Liu on 9/30/15.
//  Copyright © 2015 Anqing Liu. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Parse
import ParseUI
import Foundation

class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    //@IBOutlet var activityView: ActivityView!
    @IBOutlet weak var loginInitialLabel: UILabel!
    @IBOutlet weak var logInSavePassLabel: UILabel!
    
    
    @IBOutlet weak var loginUserTextField: UITextField!
    @IBOutlet weak var loginPassTextField: UITextField!
    @IBOutlet weak var loginSavePassSwitch: UISwitch!
    
    
    @IBAction func loginActionButton(sender: AnyObject) {
        var username = self.loginUserTextField.text
        var password = self.loginPassTextField.text
        
        // Validate the text fields
        if username?.characters.count < 5 {
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if password?.characters.count < 8 {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            // Run a spinner to show a task in progress
            var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    var alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Front") as! TimelineTableViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } else {
                    var alert = UIAlertView(title: "Error", message: "Please try again!", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }
    
    }
    //capture the username and password information

    

    @IBAction func logOutAction(sender: AnyObject){
        
        // Send a request to log out a user
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! LoginViewController
            self.presentViewController(viewController, animated: true, completion: nil)
        })
        
    }

    
override func viewDidLoad() {
        super.viewDidLoad()
    
  /*  if(loginUserTextField.text != "" && loginPassTextField.text != "")
    {
        print ("yes");
        
        // Not Empty, Do something.
    } else {
        // Empty, Notify user
        self.loginInitialLabel.text = "All Fields Required"
    }
    
    if loginSavePassSwitch.on {
        // If the user has selected YES to saving password
    } else {
        // If the user has selected NO to saving password
    }
    
    //PFUser.logInWithUsernameInBackground(<#T##username: String##String#>, password: <#T##String#>, target: <#T##AnyObject?#>, selector: <#T##Selector#>)
    PFUser.logInWithUsernameInBackground(loginUserTextField.text as String!, password: loginPassTextField.text as String!){
        (user: PFUser?, signupError: NSError?) -> Void in
        if user != nil {
            // Yes, User Exists
            self.loginInitialLabel.text = "User Exists"
        } else {
            // No, User Doesn't Exist
        }
    }*/
    
    //facebook login
        if(FBSDKAccessToken.currentAccessToken()==nil)
        {
            print("Not logged in...");
        }
        else
        {
            print("Logged in");
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions=["public_profile","email","user_friends"]
        loginButton.center = CGPoint(x: self.view.frame.size.width * 0.3, y: self.view.frame.size.height * 0.7);
        loginButton.delegate = self
    
        self.view.addSubview(loginButton)
        
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error == nil
        {
            print("Login complete.")
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out")
    }
}

