//
//  History.swift
//  expedition
//
//  Created by Eleve on 09/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import Foundation

private let model = ModelController.Model

class ModelController {
    
    static let Model = ModelController()
    let history: History
    let triggers: Triggers
    var currentSituation: Situation?
    var situations: Array<Situation>
    var days: Array<Array<Dictionary<String,AnyObject>>>
    
    private init() {
        self.history = History()
        self.triggers = Triggers()
        self.situations = []
        self.days = [[]]
        self.getData()
    }
    
    func getData() {
        if let url = NSBundle.mainBundle().URLForResource("db", withExtension: "json")
        {
            if let data = NSData(contentsOfURL: url)
            {
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    if let dictionary = object as? [String: AnyObject] {
                        
                        var txt_json = dictionary["text"] as! Array<AnyObject>
                        var media_json = dictionary["media"] as! Array<AnyObject>
                        var choice_json = dictionary["choice"] as! Array<AnyObject>
                        var answer_json = dictionary["answer"] as! Array<AnyObject>
                        
                        self.triggers.triggers_sub_sub = dictionary["trigger_sub_sub"] as? Array<AnyObject>
                        self.triggers.triggers_sub_answer = dictionary["trigger_sub_answer"] as? Array<AnyObject>
                        self.triggers.triggers_answer = dictionary["trigger_answer"] as? Array<AnyObject>
                        
                        if let situations_json = dictionary["situations"] as? Array<AnyObject>
                        {
                            for situation in situations_json
                            {
                                let id = situation.valueForKey("id") as! String
                                let place = situation.valueForKey("place") as! String
                                let name = situation.valueForKey("name") as! String
                                let delay = situation.valueForKey("delay") as! Double
                                
                                let sit = Situation(id: id, place: place, name: name, delay: delay)
                                
                                if let subs_json = dictionary["subsituations"] as? Array<AnyObject>
                                {
                                    for sub in subs_json
                                    {
                                        let parent_id = sub.valueForKey("parent_id") as? String
                                        if(parent_id == id)
                                        {
                                            let sub_id = sub.valueForKey("id")
                                            let sub_type = sub.valueForKey("type")
                                            let sub_child_id = sub.valueForKey("child_id")
                                            
                                            let sub = Subsituation(id: sub_id as! String, child_id: sub.valueForKey("child_id") as! String, type: sub_type as! String)
                                            
                                            
                                            switch sub_type as! String {
                                            case "txt":
                                                for txt in txt_json
                                                {
                                                    let txt_id = txt.valueForKey("id")
                                                    if(txt_id as? String == sub_child_id as? String)
                                                    {
                                                        sub.content = txt.valueForKey("content") as? String
                                                        
                                                        sub.received = txt.valueForKey("received") as? String
                                                        txt_json = txt_json.filter { $0.valueForKey("id") as! String != txt_id as! String }
                                                    }
                                                }
                                            case "media":
                                                for media in media_json
                                                {
                                                    let media_id = media.valueForKey("id")
                                                    if(media_id as? String == sub_child_id as? String)
                                                    {
                                                        sub.content = media.valueForKey("content") as? String
                                                        media_json = media_json.filter { $0.valueForKey("id") as! String != media_id as! String }
                                                    }
                                                }
                                            case "choice":
                                                var answers : Array<Answer> = []
                                                for choice in choice_json
                                                {
                                                    let choice_id = choice.valueForKey("id")
                                                    if(choice_id as? String == sub_child_id as? String)
                                                    {
                                                        
                                                        for answer in answer_json
                                                        {
                                                            let answer_parent_id = answer.valueForKey("parent_id")
                                                            if(answer_parent_id as? String == choice_id as? String)
                                                            {
                                                                let answer_id = answer.valueForKey("id") as! String
                                                                answers.append(Answer(content: answer.valueForKey("content") as! String, id: answer_id))
                                                                answer_json = answer_json.filter { $0.valueForKey("id") as! String != answer_id }
                                                            }
                                                        }
                                                        choice_json = choice_json.filter { $0.valueForKey("id") as! String != choice_id as! String }
                                                    }
                                                }
                                                sub.answers = answers
                                            default:
                                                break
                                            }
                                            sit.subs.append(sub)
                                        }
                                    }
                                }
                                self.situations.append(sit)
                            }
                        }
                    }
                } catch {
                    print("error")
                }
            }
        }
        
        self.currentSituation = self.situations[0]
    }
    
    func addToCurrentDay(msg: Dictionary<String,AnyObject>)
    {
        if self.days.count == 0
        {
            self.days.append([msg])
        }
        else
        {
            self.days[self.days.count - 1].append(msg)
        }
    }
    
    func getNextSub(id : String, type: String = "") {
        
        var filtered = []
        
        if type == "answer" {
            filtered = self.triggers.triggers_sub_answer!.filter { $0.valueForKey("answer_id") as? String == id }
            
            if filtered.count > 0
            {
                let triggeredId = filtered[0].valueForKey("sub_id") as? String
                
                idEvent.emit(triggeredId!)
                return
            }
            
        }
        else {
            filtered = self.triggers.triggers_sub_sub!.filter { $0.valueForKey("trigger_id") as? String == id }
            
            if filtered.count > 0
            {
                let triggeredId = filtered[0].valueForKey("triggered_id") as? String
                
                idEvent.emit(triggeredId!)
                return
            }
        }
        
        filtered = self.triggers.triggers_answer!.filter { $0.valueForKey("answer_id") as? String == self.history.lastAnswer }
        
        if filtered.count > 0
        {
            let situation_id = filtered[0].valueForKey("situation_id") as? String
            let filtersituation = self.situations.filter { $0.id == situation_id }
            let differentSituation = situation_id != self.currentSituation!.id
            
            if filtersituation.count > 0
            {
                let situation = filtersituation[0]
                
                if differentSituation
                {
                    if situation.id == "cb1b1ed5-160e-4f98-8a44-19e8e3f6c92b"
                    {
                        print("hey adele i was wondering its a new day")
                        self.days.append([])
                    }
                    
                    self.currentSituation = situation
                    Helper.delay(self.currentSituation!.delay){
                        let triggeredId = self.currentSituation?.subs[0].id
                        
                        idEvent.emit(triggeredId!)
                    }
                }
            }
        }
    }
}