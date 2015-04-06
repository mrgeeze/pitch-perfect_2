//
//  RecordSoundsViewController.swift
//  PitchPerfecto
//
//  Created by Bob Bauer on 3/10/15.
//  Copyright (c) 2015 Bob Bauer. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController,AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopRecording: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio : RecordedAudio!
    
    override func viewDidLoad() {
        recordingInProgress.hidden = false
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }

    override func viewWillAppear(animated: Bool) {
        stopRecording.hidden = true
        recordButton.enabled = true
        recordingInProgress.textColor = UIColor.blueColor()
        recordingInProgress.text = "Click on Mic To Record"
    }
    
    @IBAction func recordAudio(sender: AnyObject) {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println("Audio FilePath Name:  \(filePath)")
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        //TODO - ideally label could  be blinking like the the light in a recording studio
        // i tried a few things with timer & animating but no success. so color change & text only
        recordingInProgress.textColor = UIColor.redColor()
        recordingInProgress.text = "Recording in Progress"
        stopRecording.hidden = false
        recordButton.enabled = false
        
            }
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "stopRecording")
        {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool)
    {
        if(flag)
        {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
             self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)

        }
        else
        {
            println("recording not successful")
            recordButton.enabled = true
            stopRecording.hidden = true
        }
    }
    @IBAction func stopRecording(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

