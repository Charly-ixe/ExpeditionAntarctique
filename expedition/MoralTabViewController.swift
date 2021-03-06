//
//  MoralTabViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 12/05/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class MoralTabViewController: UIViewController {
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var centerProfilePictureImageView: UIImageView!
    @IBOutlet weak var leftProfilePictureImageView: UIImageView!
    @IBOutlet weak var rightProfilePictureImageView: UIImageView!
    @IBOutlet weak var hungerLabel: UILabel!
    @IBOutlet weak var droughtLabel: UILabel!
    @IBOutlet weak var moralLabel: UILabel!
    @IBOutlet weak var teamSpiritLabel: UILabel!
    @IBOutlet weak var hungerGauge: DrawGauge!
    @IBOutlet weak var droughtGauge: DrawGauge!
    @IBOutlet weak var moralGauge: DrawGauge!
    @IBOutlet weak var teamSpiritGauge: DrawGauge!
    @IBOutlet var leftImageViewTapGesture: UITapGestureRecognizer!
    @IBOutlet var centerImageViewTapGesture: UITapGestureRecognizer!
    @IBOutlet var rightImageViewTapGesture: UITapGestureRecognizer!
    @IBOutlet weak var centerCharacterLabel: UILabel!
    @IBOutlet weak var leftCharacterLabel: UILabel!
    @IBOutlet weak var rightCharacterLabel: UILabel!
    let guillaume = Character(name: "Guillaume")
    let valentine = Character(name: "Valentine")
    let stephane = Character(name: "Stéphane")
    weak var currentCharacter: Character?
    weak var currentCharacterView : UIView?
    weak var newCharacterView : UIView?
    
    var isSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guillaume.hunger = 20.0
        guillaume.moral = 40.0
        
        valentine.hunger = 80.0
        valentine.moral = 35.0
        valentine.teamSpirit = 5.0
        
        stephane.hunger = 0.0
        stephane.drought = 25.0
        stephane.moral = 10.0
        stephane.teamSpirit = 90.0
        
        currentCharacter = guillaume
        currentCharacterView = centerView
        currentCharacterView?.transform = CGAffineTransformMakeScale(2, 2)
//        let imageCharacter : UIImageView = currentCharacterView?.subviews.first as! UIImageView
//        imageCharacter.image = UIImage(named: "portraits2")
        
        
        setGaugesValues(currentCharacter!)
        
        centerProfilePictureImageView.layer.cornerRadius = centerProfilePictureImageView.frame.size.width / 2
        centerProfilePictureImageView.clipsToBounds = true
        centerProfilePictureImageView.layer.borderWidth = 2.0
        centerProfilePictureImageView.layer.borderColor = nunatakBlack.CGColor
        leftProfilePictureImageView.layer.cornerRadius = leftProfilePictureImageView.frame.size.width / 2
        leftProfilePictureImageView.clipsToBounds = true
        leftProfilePictureImageView.layer.borderWidth = 2.0
        leftProfilePictureImageView.layer.borderColor = nunatakBlack.CGColor
        rightProfilePictureImageView.layer.cornerRadius = rightProfilePictureImageView.frame.size.width / 2
        rightProfilePictureImageView.clipsToBounds = true
        rightProfilePictureImageView.layer.borderWidth = 2.0
        rightProfilePictureImageView.layer.borderColor = nunatakBlack.CGColor
        
        hungerLabel.textColor = nunatakBlackAlpha
        droughtLabel.textColor = nunatakBlackAlpha
        moralLabel.textColor = nunatakBlackAlpha
        teamSpiritLabel.textColor = nunatakBlackAlpha
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func leftImageViewTap(sender: UITapGestureRecognizer) {
        currentCharacter = valentine
        self.newCharacterView = leftView
        UIView.animateWithDuration(0.3, animations: {
            self.leftCharacterLabel.alpha = 1.0
            self.centerCharacterLabel.alpha = 0.0
            self.rightCharacterLabel.alpha = 0.0
            self.currentCharacterView?.transform = CGAffineTransformMakeScale(1, 1)
            self.newCharacterView?.transform = CGAffineTransformMakeScale(2, 2)
        })
        currentCharacterView = newCharacterView
        setGaugesValues(currentCharacter!)
        
//        hungerGauge.animateView(CGFloat((currentCharacter?.hunger)!))
    }
    
    @IBAction func centerImageViewTap(sender: UITapGestureRecognizer) {
        currentCharacter = guillaume
        self.newCharacterView = centerView
        UIView.animateWithDuration(0.3, animations: {
            self.leftCharacterLabel.alpha = 0.0
            self.centerCharacterLabel.alpha = 1.0
            self.rightCharacterLabel.alpha = 0.0
            self.currentCharacterView?.transform = CGAffineTransformMakeScale(1, 1)
            self.newCharacterView?.transform = CGAffineTransformMakeScale(2, 2)
        })
        currentCharacterView = newCharacterView
        setGaugesValues(currentCharacter!)
//        hungerGauge.animateView(CGFloat((currentCharacter?.hunger)!))
        
    }
    
    @IBAction func rightImageViewTap(sender: UITapGestureRecognizer) {
        currentCharacter = stephane
        self.newCharacterView = rightView
        UIView.animateWithDuration(0.3, animations: {
            self.leftCharacterLabel.alpha = 0.0
            self.centerCharacterLabel.alpha = 0.0
            self.rightCharacterLabel.alpha = 1.0
            self.currentCharacterView?.transform = CGAffineTransformMakeScale(1, 1)
            self.newCharacterView?.transform = CGAffineTransformMakeScale(2, 2)
        })
        currentCharacterView = newCharacterView
        setGaugesValues(currentCharacter!)
        
    }
    
    func setGaugesValues(currentCharacter : Character) {
        hungerGauge.gaugeValue = currentCharacter.hunger
        hungerGauge.color = hungerGauge.setNewColor(CGFloat(hungerGauge.gaugeValue))
        droughtGauge.gaugeValue = currentCharacter.drought
        droughtGauge.color = droughtGauge.setNewColor(CGFloat(droughtGauge.gaugeValue))
        moralGauge.gaugeValue = currentCharacter.moral
        moralGauge.color = moralGauge.setNewColor(CGFloat(moralGauge.gaugeValue))
        teamSpiritGauge.gaugeValue = currentCharacter.teamSpirit
        teamSpiritGauge.color = teamSpiritGauge.setNewColor(CGFloat(teamSpiritGauge.gaugeValue))
        self.hungerGauge.setNeedsDisplay()
        self.droughtGauge.setNeedsDisplay()
        self.moralGauge.setNeedsDisplay()
        self.teamSpiritGauge.setNeedsDisplay()
    }
    
    
}
