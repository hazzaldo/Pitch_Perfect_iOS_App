//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Hareth Naji on 05/01/2016.
//  Copyright © 2016 Hazzaldo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopAction(sender: UIButton) {
        //TODO: Hide 'recording' label
        recordingInProgress.hidden = true
        //TODO: stop recording
    }

    @IBAction func recordAudio(sender: UIButton) {
        //TODO: show text "Recording in progress"
        recordingInProgress.hidden = false
        //TODO: record user's voice
        print ("in recordAudio")
    }
}

