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
    @IBOutlet weak var timeView: UILabel!
    
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
        

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
