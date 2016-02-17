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
    
    //Declare Global variables
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func recordAudio(sender: UIButton) {
        //show text "Recording in progress"
        recordingInProgress.hidden = false
        //Disable record button
        recordButton.enabled = false
        //show stopButton
        stopButton.hidden = false
        //The file will be saved in the documents directory
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
                                        .UserDomainMask, true)[0] as String
        //set the name of the recording to "my_audio" .wav as the extension.
        let recordingName = "my_audio.wav"
        //The location of the file and the file name are placed in an array
        let pathArray = [dirPath, recordingName]
        //The file path is created as a constant with the contents of the array
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        /*The file path is output by the compiler in case it is required to verify where 
        the file is saved
        */
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
    }
    
     //This method/function is where all the coding goes after the audio finish recording
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
        //Step 1- save the recorded audio
            /*intialise recordedAudio as an instance of RecordedAudio class
             where the directory path of the audio file (in the form of AVAudioRecorder property 'url' of type NSURL) is assigned as the value of the 'filePathUrl' property
            And where the name of the audio file (in the form of NSURL extension property 'lastPathComponent' of type String) is assigned as the value of the 'title' property.
            */
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
        //Step 2- Move to the next scene aka perform segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
          print("Recording was not successful")
            recordingInProgress.hidden = true
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    //This function is where we pass objects before moving to the next ViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*this step becomes even more important when we have multiple segues 
        from the same VC
        */
        if (segue.identifier == "stopRecording"){
            /* where destination ViewController is PlaySoundsViewController
             assigned to variable playSoundsVC
            */
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            /* where the object (sender:AnyObject) to initiate segue is RecordedAudio
            (where audio file path and name is saved) and assigned to data variable
            */
            let data = sender as! RecordedAudio
            /* 'data' variable is then assigned to 'receivedAudio' variable (declared in
            PlaySoundsViewController), so that audio file data can be recieved by the 
            PlaySoundsViewController scene
            */
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopAction(sender: UIButton) {
        //Hide 'recording' label
        recordingInProgress.hidden = true
        //enable record button
        recordButton.enabled = true
        //stop recording
        audioRecorder.stop()
        //deactivating audio session
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}





