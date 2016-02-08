//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Hareth Naji on 05/01/2016.
//  Copyright © 2016 Hazzaldo. All rights reserved.
//

import UIKit
//The AVFoundation framework is made accessible to the code
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    //Declare Globally A variable is created for audioRecorder
    var audioRecorder:AVAudioRecorder!
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        //TODO: enable record button
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopAction(sender: UIButton) {
        //TODO: Hide 'recording' label
        recordingInProgress.hidden = true
        //enable record button
        recordButton.enabled = true
        //TODO: stop recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    @IBAction func recordAudio(sender: UIButton) {
        //The file will be saved in the documents directory
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
                                        .UserDomainMask, true)[0] as String
        
        /* The commented-out code is to name recorded audio files using date & time stamp
        //The current date is retrieved
        let currentDateTime = NSDate()
        //The object that will format the date is created
        let formatter = NSDateFormatter()
        //The date is formatted to ddMMyyyy-HHmmss
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        //The .wav file is named with the date & time of the recording
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        */
        //set the name of the recording to "my_audio"
        let recordingName = "my_audio.wav"
        //The location of the file and the file name are placed in an array
        let pathArray = [dirPath, recordingName]
        //The file path is created as a constant with the contents of the array
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        //The file path is displayed on the screen
        print(filePath)
        //A recording session is created
        let session = AVAudioSession.sharedInstance()
        //This session is made capable of playing and recording media
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        //The file path is assigned to the file that will be created in this recording session
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        /* Set RecordSoundsViewController as the delegate of audioRecorder
        (an instance of AVAudioRecorder) to implement functions from the protocol AVAudioRecorderDelegate, functions in this case
        */
        audioRecorder.delegate = self
        //Audio metering is enabled for the file that will be created
        audioRecorder.meteringEnabled = true
        //The app begins the recording
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        //show text "Recording in progress"
        recordingInProgress.hidden = false
        //Disable record button
        recordButton.enabled = false
        //show stopButton
        stopButton.hidden = false
        //This method/function is where all the coding goes after the audio finish recording
        audioRecorderDidFinishRecording(<#T##recorder: AVAudioRecorder##AVAudioRecorder#>, successfully: <#T##Bool#>)
        //TODO: Step 1- save the recorded audio
        
        //TODO: Step 2- Move to the next scene aka perform segue
    }
}

