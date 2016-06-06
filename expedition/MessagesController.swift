//
//  SecondViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 20/04/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit
import AVFoundation

class MessagesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var typing = [String: AnyObject]()
    var messages: [[String:AnyObject]] = []
    var displayedMessages: [[String:AnyObject]] = []
    private let sizingCell = MessageCell()
    private let sizingCellChoice = ChoiceCell()
    
    var day: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.typing["content"] = "==typing=="
        self.typing["received"] = "true"
                
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .None
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.tableView.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
                        
        self.setMessages()
        
        setMessageToDisplay(self.messages[0]["id"] as! String)
        
    }
    
    func setMessages(){
        self.messages = []
        for sub in ModelController.Model.currentSituation!.subs {
            
            var dico = [String: AnyObject]()
            
            dico["content"] = sub.content
            
            if (sub.received != nil)
            {
                dico["received"] = sub.received
            }
            else{
                dico["received"] = "false"
            }
            
            dico["displayed"] = "false"
            
            dico["id"] = sub.id
            
            dico["answered"] = "false"
            
            if sub.answers != nil && sub.answers?.count > 0
            {
                var answers = [[String:AnyObject]]()
                for answer in sub.answers! {
                    var ans = [String:String]()
                    ans["id"] = answer.id
                    ans["content"] = answer.content
                    ans["selected"] = "false"
                    answers.append(ans)
                    ans["received"] = "false"
                }
                dico["answers"] = answers
            }
            
            self.messages.append(dico)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func answerTap(sender:UITapGestureRecognizer) {
        
        let answer : MessageBubbleTextView = (sender.view as? MessageBubbleTextView)!
        ModelController.Model.history.saveHistory(answer.answerId!)
        answer.backgroundColor = UIColor.redColor()
        ModelController.Model.days[self.day] = ModelController.Model.days[self.day].filter({
            $0["id"] as? String != answer.subId
        })
        
        var message = [String: String]()
        message["content"] = answer.text
        message["received"] = "false"
        ModelController.Model.days[ModelController.Model.days.count - 1].append(message)
        self.tableView.reloadData()
        
        let systemSoundID: SystemSoundID = 1004
        
        // to play sound
        AudioServicesPlaySystemSound (systemSoundID)
        
        idEvent.once { nextId in
            self.setMessageToDisplay(nextId)
        }
        ModelController.Model.getNextSub(answer.answerId!, type: "answer")
        
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.tableView.numberOfSections
            let numberOfRows = self.tableView.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    func setMessageToDisplay(id: String) {
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum);
        
        var bgTask = UIBackgroundTaskIdentifier()
        bgTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(bgTask)
        }
        
        if id != "" && ModelController.Model.days.count - 1 == self.day
        {
            var newMessageArray = self.messages.filter({
                $0["id"] as! String == id //access the value to filter
            })
            
            if newMessageArray.count == 0
            {
                self.setMessages()
                newMessageArray = self.messages.filter({
                    $0["id"] as! String == id //access the value to filter
                })
            }
            
            if newMessageArray.count > 0 {
                var newMessage = newMessageArray[0]
                
                var toDisplay = [String: AnyObject]()
                
                toDisplay["id"] = newMessage["id"] as? String
                
                var t : Double = 2
                
                if newMessage["answers"] != nil
                {
                    toDisplay["type"] = "choice"
                    
                    var answers = [AnyObject]()
                    
                    for answer in newMessage["answers"] as! NSArray
                    {
                        var ans = [String:String]()
                        ans["id"] = answer["id"] as? String
                        ans["content"] = answer["content"] as? String
                        answers.append(ans)
                    }
                    toDisplay["answers"] = answers
                }
                else
                {
                    toDisplay["content"] = newMessage["content"] as? String
                    toDisplay["received"] = newMessage["received"] as? String
                    
                    let content = toDisplay["content"] as! String
                    t = Double(content.characters.count) / 14
                    
                    // TESTING
                    t = 0
                    
                }
                
                
                Helper.delay(1) {
                    if toDisplay["type"] as? String != "choice"
                    {
                        ModelController.Model.days[ModelController.Model.days.count - 1].append(self.typing)
                        self.tableView.reloadData()
                        self.tableViewScrollToBottom(true)
                    }
                    
                    Helper.delay(t) {
                        
                        badgeEvent.emit("")
                        let State = UIApplication.sharedApplication().applicationState
                        if State.rawValue != 0
                        {
                            let notification:UILocalNotification = UILocalNotification()
                            notification.category = "Expédition Antarctique"
                            notification.alertTitle = "Expédition Antarctique"
                            notification.alertAction = "répondre à l'explorateur"
                            notification.alertBody = "Sélectionnez une réponse"
                            if let body = toDisplay["content"] as? String {
                                notification.alertBody = body
                                notification.alertAction = "afficher le nouveau message"
                            }
                            
                            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
                        }
                        
                        let lastMessage = ModelController.Model.days[ModelController.Model.days.count - 1].last
                        
                        if lastMessage!["content"] as? String == "==typing=="
                        {
                            ModelController.Model.days[ModelController.Model.days.count - 1].removeLast()
                        }
                    
                        ModelController.Model.days[ModelController.Model.days.count - 1].append(toDisplay)
                    
                        if toDisplay["type"] as? String != "choice"
                        {
                        
                            idEvent.once { nextId in
                                if(nextId != "")
                                {
                                    self.setMessageToDisplay(nextId)
                                    self.tableView.reloadData()
                                    self.tableViewScrollToBottom(true)
                                }
                            }
                        
                            var msg = [String:String]()
                            msg["content"] = toDisplay["content"] as? String
                            msg["received"] = toDisplay["received"] as? String
                            
                            let systemSoundID: SystemSoundID = 1003
                            
                            // to play sound
                            AudioServicesPlaySystemSound (systemSoundID)
                        }
                        self.tableView.reloadData()
                        
                        self.tableViewScrollToBottom(true)
                    
                        ModelController.Model.getNextSub(id)
                    }
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 100
        if ModelController.Model.days[self.day][indexPath.row]["type"] as? String != "choice"
        {
            sizingCell.bounds.size.width = CGRectGetWidth(self.view.bounds)
            height = self.sizingCell.setupWithMessage(ModelController.Model.days[self.day][indexPath.row]).height;
        }
        else
        {
            sizingCellChoice.bounds.size.width = CGRectGetWidth(self.view.bounds)
            height = self.sizingCellChoice.setupWithMessage(ModelController.Model.days[self.day][indexPath.row]["answers"] as! [[String : AnyObject]]).height;
        }
        return height
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  ModelController.Model.days.count > 0
        {
            return ModelController.Model.days[self.day].count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let message = ModelController.Model.days[self.day][indexPath.row]
        
        if message["type"] as? String == "choice"{
            
            let cell: ChoiceCell
            cell = self.tableView.dequeueReusableCellWithIdentifier("messageCellChoice") as! ChoiceCell
            
            cell.frame = CGRectMake(0,
                                    0,
                                    self.tableView.frame.size.width,
                                    cell.frame.size.height);
            cell.backgroundColor = UIColor.clearColor()
            
            if message["answers"]?.count > 0
            {
                cell.setupWithMessage(message["answers"] as! [[String : AnyObject]], subId: message["id"] as! String)
                for answer in cell.contentView.subviews {
                    answer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.answerTap)))
                }
            }
            
            for v in cell.subviews[0].subviews {
                v.layer.shadowColor = UIColor(red:0.14, green:0.35, blue:0.73, alpha:1.0).CGColor
                v.layer.shadowOffset = CGSize(width: 0, height: 0)
                v.layer.shadowOpacity = 0.1
                v.layer.shadowRadius = 5
            }
            
            cell.layer.masksToBounds = false
            cell.clipsToBounds = false
            
            return cell
        }
        else
        {
            let cell: MessageCell
            cell = self.tableView.dequeueReusableCellWithIdentifier("messageCellReceived") as! MessageCell
            
            cell.frame = CGRectMake(0,
                                    0,
                                    self.tableView.frame.size.width,
                                    cell.frame.size.height);
            cell.setupWithMessage(message)
            
            cell.backgroundColor = UIColor.clearColor()
            
            let v = cell.subviews[0]
            v.layer.shadowColor = UIColor(red:0.14, green:0.35, blue:0.73, alpha:1.0).CGColor
            v.layer.shadowOffset = CGSize(width: 0, height: 0)
            v.layer.shadowOpacity = 0.1
            v.layer.shadowRadius = 10
                        
            cell.layer.masksToBounds = false
            cell.clipsToBounds = false
            
            return cell
        }
    }
}
