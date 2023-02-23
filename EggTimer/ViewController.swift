//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var DoneLabel: UILabel!
    @IBOutlet weak var CountLabel: UILabel!
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 720]
    var totalTime = 0
    var secondPassed = 0
    
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        secondPassed = 0
        progressBar.progress = 0
        DoneLabel.text = hardness
        
        timer.invalidate()
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update()
    {
        if secondPassed < totalTime
        {
            secondPassed += 1
            let percentageProgess : Float = Float(secondPassed) / Float(totalTime)
            progressBar.progress = percentageProgess
            CountLabel.text = String(totalTime - secondPassed)
        }
        else
        {
            timer.invalidate()
            CountLabel.text = String(totalTime - secondPassed)
            progressBar.progress = 1
            DoneLabel.text  = "Done!"
            playSound()
        }
    }
    
    func playSound()
    {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    
}
