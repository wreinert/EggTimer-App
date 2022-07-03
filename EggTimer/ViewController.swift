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
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var changeLabel = false
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle
        if hardness != nil {
            totalTime = eggTimes[hardness!]!
        }
        progressBar.progress = 0
        secondsPassed = 0
        statusLabel.text = hardness!
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
        if secondsPassed <= totalTime {
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
            secondsPassed += 1
        }
        else {
            timer.invalidate()
            statusLabel.text = "Done!"
            playSound(soundName: "alarm_sound")
        }
    }
    func playSound(soundName: String ) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
