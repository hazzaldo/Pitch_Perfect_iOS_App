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
    }

    @IBAction func recordAudio(sender: UIButton) {
        //show text "Recording in progress"
        recordingInProgress.hidden = false
        //Disable record button
        recordButton.enabled = false
        //show stopButton
        stopButton.hidden = false
        //TODO: record user's voice
        print ("in recordAudio")
    }
}

