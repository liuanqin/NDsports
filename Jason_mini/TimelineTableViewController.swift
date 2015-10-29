//
//  TimelineTableViewController.swift
//  Jason_mini
//
//  Created by Anqing Liu on 10/27/15.
//  Copyright © 2015 Anqing Liu. All rights reserved.
//

import UIKit
import Parse


class TimelineTableViewController: UITableViewController {
    
  var timelineData:NSMutableArray=NSMutableArray()

    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
   @IBAction func loadData(){
        timelineData.removeAllObjects()
        
        var findTimelineData:PFQuery = PFQuery(className: "Send")
      
        //findTimelineData.findObjectsInBackgroundWithBlock(<#T##block: PFQueryArrayResultBlock?##PFQueryArrayResultBlock?##([PFObject]?, NSError?) -> Void#>)
        findTimelineData.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error:NSError?)->Void in
            
            if error == nil{
                for object in objects!{
                    let send:PFObject = object as! PFObject
                    self.timelineData.addObject(send)
                }
                
                let array:NSArray = self.timelineData.reverseObjectEnumerator().allObjects
                self.timelineData = NSMutableArray(array: array)
                
                self.tableView.reloadData()
                
            }
            
        }
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
override func viewDidAppear(animated: Bool) {
        self.loadData()
        
        if (PFUser.currentUser() == nil){
            var loginAlert:UIAlertController = UIAlertController(title:"Login", message: "Please Log In", preferredStyle: UIAlertControllerStyle.Alert)
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your username"
            })
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your password"
                textfield.secureTextEntry = true
            })
            
            loginAlert.addAction(UIAlertAction(title: "login", style: UIAlertActionStyle.Default, handler: {
                    alertAction in
                let textFields:NSArray = loginAlert.textFields! as NSArray
                let usernameTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
                let passwordTextField:UITextField = textFields.objectAtIndex(1) as! UITextField
                
                PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!)
                    {(user: PFUser?, error: NSError?) -> Void in
                        if ((user) != nil) {
                        print("Login Successfully")
                    }else{
                        print("Login Failed, Please try again!")
                    }
                    }
            }))
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
            
            
        }
}
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // #pragma mark - Table view data source
        
        override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
            // #warning Potentially incomplete method implementation.
            // Return the number of sections.
            return 1
        }
        
        override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete method implementation.
            // Return the number of rows in the section.
            return timelineData.count
        }
 
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:MessageTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MessageTableViewCell
    
        let send:PFObject = self.timelineData.objectAtIndex(indexPath.row) as! PFObject
    
    cell.sweetTextView.alpha = 0
    cell.timestampLabel.alpha = 0
    cell.usernameLabel.alpha = 0

       cell.sweetTextView.text = send.objectForKey("contents") as? String
            
        var dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.timestampLabel.text = dataFormatter.stringFromDate(send.createdAt!)

        
        if let sweeter: PFObject = send.objectForKey("author") as? PFObject {
            var findSweeter:PFQuery = PFUser.query()!
            findSweeter.whereKey("objectId", equalTo: sweeter.objectId!)
        
        findSweeter.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error:NSError?)->Void in
            if error == nil{
                let user:PFUser = (objects! as NSArray).lastObject as! PFUser
                cell.usernameLabel.text = user.username
                
                UIView.animateWithDuration(0.5, animations: {
                        cell.sweetTextView.alpha = 1
                        cell.timestampLabel.alpha = 1
                        cell.usernameLabel.alpha = 1
                    })
            }
            }}
        return cell
    }
}

