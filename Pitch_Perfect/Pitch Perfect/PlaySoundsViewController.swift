//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Hareth Naji on 25/01/2016.
//  Copyright © 2016 Hazzaldo. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer:AVAudioPlayer!

class PlaySoundsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let string_path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        let url_path = NSURL.fileURLWithPath(string_path!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url_path)
            audioPlayer.enableRate = true
        } catch {
            print("No sound file found. Please check directory where sound file is expected and file type")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.play()
        
    }
    
    @IBAction func stopAudio(sender: UIButton) {
       audioPlayer.stop() 
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


