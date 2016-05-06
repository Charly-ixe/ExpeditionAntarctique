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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sample Messages
        
        let message = Message(id: "5667-977", idSituation: "57756-68-98", name: "Arrivé à Dumont", idChild: "365-8654-34", messageType: 0)
        let messageDeux = Message(id: "5667-'477", idSituation: "5286-68-98", name: "Début de mission", idChild: "36-7314-34", messageType: 2)
        
        self.messagesArray = [message.name, messageDeux.name]
        
        print(message.name)
        
        
        
        
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
        
        cell.textLabel?.text = self.messagesArray[indexPath.row] as? String
        
        // Return the cell
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesArray.count
    }


}

