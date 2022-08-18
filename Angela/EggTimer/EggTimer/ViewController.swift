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
    
    let eggTimes : [String: Int] = ["Soft": 180, "Medium": 420, "Hard": 720]
    var audioPlayer : AVAudioPlayer!
    
    var timer = Timer()
    var totalTime = 0 //전체 초
    var secondPassed = 0 //진행중인 초
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    
    @IBAction func HardnessSelected(_ sender: UIButton) {
        //시작할 때
        timer.invalidate() //타이머 초기화
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        totalTime = eggTimes[hardness]!
        
        //종료되었을 때
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    	
    @objc func updateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1 // 초 증가
            let percentageProgress = Float(secondPassed) / Float(totalTime) // 정수끼리 나누면 정수가 되어 각 각 Int에서 Float으로 바꿔줌
            progressBar.progress = percentageProgress
        
        } else {
            timer.invalidate()
            playSound()
            titleLabel.text = "Done!"
        }
    }
    // 종료 되었을 때 소리 출력
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        audioPlayer.play()
    }
}

