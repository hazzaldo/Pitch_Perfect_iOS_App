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
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Use this code to play the movie quote audio file
        // Do any additional setup after loading the view.
        let string_path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        let url_path = NSURL.fileURLWithPath(string_path!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url_path)
            audioPlayer.enableRate = true
        } catch {
            print("No sound file found. Please check directory where sound file is expected and file type")
        }
        */
        //Audio Engine is initialized in viewDidLoad()
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile (forReading: receivedAudio.filePathUrl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudio (){
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.rate = 0.5
        playAudio()
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.rate = 1.5
        playAudio()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
    playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch (pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(audioPlayerNode, to: timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        
        try! audioEngine.start()
        audioPlayerNode.play()
        
    }

    @IBAction func stopAudio(sender: UIButton) {
       audioPlayer.stop()
       audioEngine.stop()
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


