//
//  MessageTableViewCell.swift
//  Jason_mini
//
//  Created by Anqing Liu on 10/28/15.
//  Copyright © 2015 Anqing Liu. All rights reserved.
//

import UIKit
import Parse

class MessageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var objectidLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var sweetTextView: UITextView!
    @IBOutlet weak var locationView: UILabel!
    @IBOutlet weak var sportsView: UILabel!
    
    var parseObject:PFObject?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBOutlet weak var voteButton: UIButton!
        
      /*  var query = PFQuery(className: "Send")
        query.whereKey("objectId",equalTo: voteLabel.objectId)
        query.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error:NSError?)->Void in
            if error == nil{

        objects.incrementKey("votes")
        objects.saveInBackground()
            }}}*/
        /*let send:PFObject = PFObject(className: "Send")
        if let voter: PFObject = send.objectForKey("votes") as? PFObject {
            var findvoter:PFQuery = PFUser.query()!
            findvoter.whereKey("objectId", equalTo: voter.objectId!)
            //cell?.parseObject = object
            
            
            findvoter.findObjectsInBackgroundWithBlock{
                (objects:[PFObject]?, error:NSError?)->Void in
                if error == nil{
   
        if var votes: Int? = send.objectForKey("votes") as? Int!{
            print(votes)
            if votes == nil{
                votes = 0
            }
                votes!++
                send["votes"] = votes!
                print(votes)
               // parseObject!.setObject(votes!, forKey: "votes");
                send.saveInBackground();

               // voteLabel.text = "\(votes!) votes";
                    }}}}}*/
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
