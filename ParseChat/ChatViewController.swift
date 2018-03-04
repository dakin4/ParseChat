//
//  ChatViewController.swift
//  ParseChat
//
//  Created by David King on 3/3/18.
//  Copyright © 2018 David King. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var ChatTableView: UITableView!
    
    
    @IBOutlet weak var MessageField: UITextField!
    
    var messageClicked = false
    
    var messages: [PFObject] = []
    
    @IBAction func MessageClicked(_ sender: AnyObject) {
        
        MessageField.text = ""
        messageClicked = true
        
    }
    
    @IBAction func LogoutClicked(_ sender: AnyObject) {
        PFUser.logOutInBackground()
        
        self.performSegue(withIdentifier: "LogoutSegue", sender: self)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ChatTableView.dataSource = self
        getMessages()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        
        // Auto size row height based on cell autolayout constraints
        ChatTableView.rowHeight = UITableViewAutomaticDimension
        
        //Provide an estimated row height. Used for calculating scroll indicators
        ChatTableView.estimatedRowHeight = 50
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func SendClicked(_ sender: AnyObject) {
        if (messageClicked == true)
        {
            if (MessageField.text == "")
            {
                // do nothing
                
            }
            else
            {
                ChatMessage.send(mess: MessageField.text!)
                MessageField.text = ""
            }
        }
        
        
    }
    
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    
    return self.messages.count
    }
    
    
  
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatTableViewCell
        print("cell function")
         let currentMessage = messages[indexPath.row]
        
        if let text = currentMessage["text"]
        {
            cell.ChatLabel.text = text as! String
            print("\n")
            print("message texting")
            var g = text as! String
            print(g)
            print("\n")
            
        }
        
        if let user = currentMessage["user"]
        {
            let user = user as! PFUser
            
            cell.UserLabel.text = user.username
        }
        else{
            
            cell.UserLabel.text = "🤖"
        }
        
        return cell
    }
    
    func onTimer() {
        
        getMessages()
        
    }
    
    
    
   func  getMessages () {
    
   if let query = ChatMessage.query()
    
   {
    query.addDescendingOrder("createdAt")
    query.includeKey("author")
    query.includeKey("user")
    
    //query.limit = 20
    
    query.findObjectsInBackground(block: { (message: [PFObject]?, error: Error?) -> Void in
        
     if let message = message
     {
        self.messages = message
        
        self.ChatTableView.reloadData()
        
        print("Grabbing messages \n")
    
        
        }
     else
     {
        print(error)
        }
        
    })
    
    }
    
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
