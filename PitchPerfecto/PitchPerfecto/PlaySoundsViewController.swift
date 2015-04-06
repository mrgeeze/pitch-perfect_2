//
//  PlaySoundsViewController.swift
//  PitchPerfecto
//
//  Created by Bob Bauer on 3/11/15.
//  Copyright (c) 2015 Bob Bauer. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController:UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playAudioWithSpeed(0.5)
    }

    @IBAction func playFast(sender: UIButton) {
        playAudioWithSpeed(1.5)
            }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    @IBAction func playChipMunkAudio(sender: UIButton)
    {
        playAudioWithVariablePitch(1000)
     }
    
    
    func playAudioWithVariablePitch(pitch:Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    @IBAction func playbackStop(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()

    }
    @IBAction func playDarthVaderAudio(sender: UIButton)
    {
        playAudioWithVariablePitch(-1000)
    }
  
    func playAudioWithSpeed(speed:Float)
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioPlayer.currentTime = 0.0
        audioEngine.reset()
        audioPlayer.rate = speed
        audioPlayer.play()
        
    }
}
