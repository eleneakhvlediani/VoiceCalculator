//
//  ViewController.swift
//  VoiceCalculator
//
//  Created by Elene Akhvlediani on 8/8/17.
//  Copyright © 2017 Elene Akhvlediani. All rights reserved.
//

import UIKit
import Speech
class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    lazy var calculator = Calculator.sharedInstance

    let audioEngine = AVAudioEngine()
    let speechRecognizer:SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickListenButton(_ sender: UIButton) {
        recordAndRecognizeSpeech()
    }
    
    func recordAndRecognizeSpeech() {
        guard let node = audioEngine.inputNode else { return}
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
            
        }catch {
            print(error)
            return
        }
        
        guard  let myRecognizer  = speechRecognizer else {
            return
        }
        if !myRecognizer.isAvailable {
            return
        }
        
        recognitionTask  = myRecognizer.recognitionTask(with: request, resultHandler: { (result, error) in
            if let result = result {
                let bestString = result.bestTranscription.formattedString
                print(bestString)
                
            }else if let error = error {
                print(error)
            }
        })

    }

}

