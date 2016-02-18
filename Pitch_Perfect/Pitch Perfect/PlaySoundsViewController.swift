//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Hareth Naji on 25/01/2016.
//  Copyright © 2016 Hazzaldo. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    //Declare Global variables
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialise AVAudioPlayer with the saved Audio file URL
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        //Audio Engine is initialized in viewDidLoad()
        audioEngine = AVAudioEngine()
        //initialise AVAudioFile with the saved Audio file URL
        audioFile = try! AVAudioFile (forReading: receivedAudio.filePathUrl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func stopAudioPlayerAndEngine(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    //function, which plays audio file to be called by Slow and Fast audio functions
    func playAudio (rate: Float){
        audioPlayer.rate = rate
        stopAudioPlayerAndEngine()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudio(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudio(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    /*function which utilise AVAudioEngine to create and setup AVAudioUnitTimePitch
     node to be then called and utilised by Chipmunk and DarthVader audio functions
    to specify a pitch paratmeter that will give the desired pitch for the relevant 
    sound effect
    */
    func playAudioWithVariablePitch (pitch: Float){
        stopAudioPlayerAndEngine()
        
        /*create nodes of AVAudioPlayerNode (input node) and AVAudioUnitTimePitch
        (proccess node) to then attached to the AVAudioEngine ready to be connected 
        in an active feed thread
        */
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        let timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        audioEngine.attachNode(timePitch)
        /* Connecting AVAudioPlayerNode and AVAudioUnitTimePitch to the AVAudioEngine
        output node to create a full active chain feed thread, ready to feed audio
        input
        */
        audioEngine.connect(audioPlayerNode, to: timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        //schedule time to play audio
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        //start AudioEngine and play AudioPlayer
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    
    //stop all any audio being played
    @IBAction func stopAudio(sender: UIButton) {
       stopAudioPlayerAndEngine()
    }
    
}



