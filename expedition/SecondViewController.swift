//
//  SecondViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 20/04/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageTableView: UITableView!
    
    var messagesArray = []
    var conversation = Conversation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Sample Messages
        
        let message = Message(id: "5667-977", idSituation: "57756-68-98", name: "Arrivée à Dumont", idChild: "365-8654-34", messageType: 0)
        let messageDeux = Message(id: "5667-'477", idSituation: "5286-68-98", name: "Début de mission", idChild: "36-7314-34", messageType: 2)
        
        message.content = "Nous arrivons à la base"
        messageDeux.content = "Nous partons en mission"
        
        conversation.currentMessage = message.id
        conversation.conversationHistory = [message]
        
        
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Create a cell
        
        let cell = self.messageTableView.dequeueReusableCellWithIdentifier("MessageCell")! as UITableViewCell
        
        
        // Customize the cell
        
        let messageForDisplay = conversation.conversationHistory.objectAtIndex(indexPath.row) as! Message
        print(messageForDisplay.content)
        
        cell.textLabel?.text = messageForDisplay.content
        
        // Return the cell
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversation.conversationHistory.count
    }


}

