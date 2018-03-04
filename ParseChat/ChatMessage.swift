//
//  ChatMessage.swift
//  ParseChat
//
//  Created by David King on 3/3/18.
//  Copyright © 2018 David King. All rights reserved.
//

import Foundation
import Parse

class ChatMessage: PFObject, PFSubclassing{
    
    @NSManaged var text: String
    
    @NSManaged var user: PFUser
    
    
    class func parseClassName () -> String {
        
    return "Message"
    }
    
    class func send (mess: String) -> Void
    {
        
        let chat = ChatMessage ()
        chat.user = PFUser.current()!
        chat.text = mess
        
        chat.saveInBackground()
        
        print("sent")
    }
    
    
    
    
}
