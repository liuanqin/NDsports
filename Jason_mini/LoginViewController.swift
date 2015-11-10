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
import ParseFacebookUtilsV4

class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {
    
    
    //@IBOutlet var activityView: ActivityView!
    @IBOutlet weak var loginInitialLabel: UILabel!
   
    
    @IBOutlet weak var displayLabel: UILabel!
    
    
    @IBOutlet weak var loginUserTextField: UITextField!
    @IBOutlet weak var loginPassTextField: UITextField!
    
    
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
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("postNavigationController") as! UINavigationController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                } else {
                    var alert = UIAlertView(title: "Error", message: "Please try again!", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }
        NSUserDefaults.standardUserDefaults().setObject(self.loginUserTextField.text, forKey: "username")
        
        let userName = NSUserDefaults.standardUserDefaults().stringForKey("username")
        print(userName)
    
    }
    //capture the username and password information

    

    @IBAction func logOutAction(sender: AnyObject){
        //print(PFUser.currentUser()?.username)
        // Send a request to log out a user
        PFUser.logOut()
        self.viewDidLoad()
        
        if (PFUser.currentUser() != nil){
            
            print(PFUser.currentUser()?.username)
        }
        
        
    }

   
    
 

    
override func viewDidLoad() {
        super.viewDidLoad()

    
    //facebook login
    if (PFUser.currentUser()?.username != nil){
        displayLabel.text = "Hello, " + (PFUser.currentUser()?.username!)!
    }
    else {
         displayLabel.text = "Login Please!"
    }

    
    if(FBSDKAccessToken.currentAccessToken()==nil)
    {
        print("Not logged in...");
    }
    }
    
    
    
    let permisions = ["public_profile"]
    var requestParameters = ["fields": "id, email, first_name, last_name"]
    

    
    @IBAction func loginFB (sender: AnyObject) {
    
      var loginFB = loginButton
        
    PFFacebookUtils.logInInBackgroundWithReadPermissions(permisions) {
    (user: PFUser?, error: NSError?) -> Void in
    
    if let error = error {
    print(error)
    } else {
    if let user = user {
    print(user)
        
        var requestParameters = ["fields": "id, email, first_name, last_name"]
        
        let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        
        userDetails.startWithCompletionHandler { (connection, result, error:NSError!) -> Void in
            
            if(error != nil)
            {
                print("\(error.localizedDescription)")
                return
            }
            
            if(result != nil)
            {
                
                let userId:String = result["id"] as! String
                let userFirstName:String? = result["first_name"] as? String
                let userEmail:String? = result["email"] as? String
                
                
                print("1\(userEmail)")
                
                // Save first name
                if(userFirstName != nil)
                {
                    user.setObject(userFirstName!, forKey: "username")
                    
                }
                
                
                // Save email address
                if(userEmail != nil)
                {
                    user.setObject(userEmail!, forKey: "email")
                }
                print("2\(userEmail)")
                user.saveInBackground()
                print("3\(userEmail)")
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    
                    print("4\(userEmail)")
                    /*
                    myUser.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                    
                    if(success)
                    {
                    print("User details are now updated")
                    myUser = PFUser.currentUser()!
                    
                    }
                    
                    })*/
                    
                }
                
            }
        }

       
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("postNavigationController") as! UINavigationController
            self.presentViewController(viewController, animated: true, completion: nil)})
    
  
    }
    
    }}
    
    //let loginButton = FBSDKLoginButton()
    //loginButton.readPermissions=["first_name","email","user_friends"]
    
    
   // loginButton.center = CGPoint(x: self.view.frame.size.width * 0.4, y: self.view.frame.size.height * 0.8);
   // loginButton.delegate = self

    
    //self.view.addSubview(loginButton)
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error == nil
        {

      loginButton.addTarget(self, action: "loginFB", forControlEvents: .TouchUpInside)
            
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}

