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
    cell.voteLabel.alpha = 0

        
       cell.sweetTextView.text = send.objectForKey("contents") as? String
        print(cell.sweetTextView.text)
        //cell.objectidLabel.text = send.objectId
        
        cell.locationView.text = send.objectForKey("location") as? String
        
        cell.sportsView.text = send.objectForKey("sports") as? String
     
        
        var dataFormatter:NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.timestampLabel.text = dataFormatter.stringFromDate(send.createdAt!)
        
        cell.voteButton.addTarget(self, action: "vote:", forControlEvents: .TouchUpInside)
        cell.voteButton.tag = indexPath.row

        
        var votes: Int = (send.objectForKey("votes") as? Int)!
        cell.voteLabel.text = "\(votes)" + " people"
        print(cell.voteLabel.text)

        
        if let sweeter: PFObject = send.objectForKey("author") as? PFObject {
            var findSweeter:PFQuery = PFUser.query()!
            findSweeter.whereKey("objectId", equalTo: sweeter.objectId!)
            //cell?.parseObject = object
            
            
        findSweeter.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error:NSError?)->Void in
            if error == nil{
                let user:PFUser = (objects! as NSArray).lastObject as! PFUser
                cell.usernameLabel.text = user.username

     
                UIView.animateWithDuration(0.5, animations: {
                        cell.sweetTextView.alpha = 1
                        cell.timestampLabel.alpha = 1
                        cell.usernameLabel.alpha = 1
                        cell.voteLabel.alpha = 1
                    })
            }}}
        return cell
    
        }

    
    @IBAction func vote(sender: UIButton){
        
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
            loginAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                
                loginAlert .dismissViewControllerAnimated(true, completion: nil)
                
                
            }))
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
            
            
        }

        sender.enabled = false
        sender.userInteractionEnabled = false
        sender.alpha = 0.5
        
        //var send = PFObject(className: "Send")
        
        let sendRow:PFObject = self.timelineData.objectAtIndex(sender.tag) as! PFObject
 
        var votes: Int? = sendRow.objectForKey("votes") as? Int
        print(votes)
        // print(send.objectForKey("objectId"))
          votes!++
        sendRow["votes"] = votes!
        print(votes)
        //let usernameLabel = sender.superview?.viewWithTag(sender.tag)
        //usernameLabel?.setNeedsDisplay()
        loadData()

        sendRow.saveInBackground()
                }}
     


