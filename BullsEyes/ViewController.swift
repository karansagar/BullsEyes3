//
//  ViewController.swift
//  BullsEyes
//
//  Created by Karan Sagar on 25/03/19.
//  Copyright © 2019 Karan. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
        
    var currentSliderValue = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    @IBOutlet weak var targetLabel: UILabel!
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    var gameRound = 0
    @IBOutlet weak var roundNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.'
        
        currentSliderValue = lroundf(slider.value)
        startNewRound()
        
        let thumbImage = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImage, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let incents = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackerLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizeable = trackerLeftImage?.resizableImage(withCapInsets: incents)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)

        let trackerRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizeable = trackerRightImage?.resizableImage(withCapInsets: incents)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
    }
    
    //Updated all the labels
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundNumber.text = String(gameRound)
    }
    
    //Start a new Round
    func startNewRound()  {
        gameRound += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentSliderValue = 25
        slider.value  = Float(currentSliderValue)
        updateLabels()
    }
    
    //StartOver
    @IBAction func startOver(_ sender: UIButton) {
        score = 0
        gameRound = 0
        startNewRound()
    }
    
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("value of the slider is \(slider.value)")
        currentSliderValue = lroundf(slider.value)
    }
    
    @IBAction func hitme() {
        
        let difference = abs(targetValue - currentSliderValue)
        var points = 100 - difference
        
        // Bonus Points if user Score 0 difference than 100 + and less than 5 then 50+
        let title: String
        if difference == 0 {
            title = "Perfect you slided at:\(currentSliderValue)"
            points += 100
        } else if difference < 5 {
            title = "Almost had it you slided at:\(currentSliderValue)"
            points += 50
        } else if difference < 10 {
            title = "Pretty Good ! you slided at:\(currentSliderValue)"
        } else {
            title = "Not even Close, try harder ! you slided at:\(currentSliderValue)"
        }
        score += points // score = score + points
        
        let valueMessage = "You Scored \(points) Points ! "
        let alert = UIAlertController(title: title, message: valueMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
                self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
