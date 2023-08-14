//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFAudio
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var secondsPassed = 0
    var totalTime = 0
    
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        secondsPassed = 0
        progressBar.progress = 0.0
        labelTitle.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1
                self.progressBar.progress = Float(self.secondsPassed) / Float(self.totalTime)
            } else {
                self.timer.invalidate()
                self.labelTitle.text = "DONE!"
                
                let url = Bundle.main.url(forResource: "alarm_sound",withExtension: "mp3")
                self.player = try! AVAudioPlayer(contentsOf: url!)
                self.player.play()
              }
        }
    }
}
