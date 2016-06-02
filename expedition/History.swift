//
//  History.swift
//  expedition
//
//  Created by Thomas BOULONGNE on 10/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import Foundation

class History {
    var history: Array<String>
    var lastAnswer: String?
    
    init() {
        self.history = []
        if let url = NSBundle.mainBundle().URLForResource("history", withExtension: "json")
        {
            if let data = NSData(contentsOfURL: url)
            {
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    if let array = object as? Array<String> {
                        self.history = array
                    }
                } catch {
                    print("error")
                }
            }
        }
    }
    
    func saveHistory(s: String) {
        self.history.append(s);
        self.lastAnswer = s
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(self.history, options: NSJSONWritingOptions.PrettyPrinted)
            let string = NSString(data: jsonData, encoding: NSUTF8StringEncoding)
            
            if let url = NSBundle.mainBundle().URLForResource("history", withExtension: "json")
            {
                do {
                    let fileHandle = try NSFileHandle(forWritingToURL: url)
                    fileHandle.writeData(string!.dataUsingEncoding(NSUTF8StringEncoding)!)
                    fileHandle.closeFile()
                    print("***** Data saved to history file *****")
                }
                catch{
                    do {
                        try string!.dataUsingEncoding(NSUTF8StringEncoding)!.writeToURL(url, options: .DataWritingAtomic)
                    }
                    catch{
                    }
                }
            }
        }catch{
            print("error2")
        }
        
    }
    
    func getHistory() -> Array<String> {
        return self.history;
    }
    
    //    func getDays() -> Array<Day> {
    //        return self.days;
    //    }
    //
    //    func getDay(i: Int) -> Day {
    //        return self.days[i];
    //    }
}