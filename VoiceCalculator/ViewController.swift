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
    
    @IBOutlet weak var resultLabel: UILabel!
    lazy var calculator = Calculator.sharedInstance
    var capture: AVCaptureSession?
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer:SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    var request : SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    
    var expression:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text  = Words.resultWillBeWrittenHere.rawValue
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickListenButton(_ sender: UIButton) {
        if capture?.isRunning == true {
     
            endRecognizer()
            sender.setTitle(Words.listen.rawValue, for: .normal)
        }else{
            resultLabel.text = Words.listening.rawValue
            sender.setTitle(Words.stop.rawValue, for: .normal)
            startRecognizer()
        }
        
    }
    
    func endRecognizer() {
        endCapture()
        request?.endAudio()
    }
    func endCapture() {
        
        if capture?.isRunning == true {
            capture?.stopRunning()
        }
    }
    func startCapture() {
        
        capture = AVCaptureSession()
        
        guard let audioDev = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio) else {
            print("Could not get capture device.")
            return
        }
        
        guard let audioIn = try? AVCaptureDeviceInput(device: audioDev) else {
            print("Could not create input device.")
            return
        }
        
        guard true == capture?.canAddInput(audioIn) else {
            print("Couls not add input device")
            return
        }
        
        capture?.addInput(audioIn)
        
        let audioOut = AVCaptureAudioDataOutput()
        audioOut.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        
        guard true == capture?.canAddOutput(audioOut) else {
            print("Could not add audio output")
            return
        }
        
        capture?.addOutput(audioOut)
        audioOut.connection(withMediaType: AVMediaTypeAudio)
        capture?.startRunning()
        
        
    }
    func startRecognizer() {
        SFSpeechRecognizer.requestAuthorization { (status) in
            switch status {
            case .authorized:
                let sf = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
                self.request = SFSpeechAudioBufferRecognitionRequest()
                sf?.recognitionTask(with: self.request!, delegate: self)
                DispatchQueue.main.async {
                    self.startCapture()
                }
            case .denied:
                fallthrough
            case .notDetermined:
                fallthrough
            case.restricted:
                print("User Autorization Issue.")
            }
        }
        
    }
    
    
    
}
extension ViewController: AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        request?.appendAudioSampleBuffer(sampleBuffer)
    }
    
}

extension ViewController: SFSpeechRecognitionTaskDelegate {
    
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition recognitionResult: SFSpeechRecognitionResult) {
        
        for t in recognitionResult.transcriptions {
            
            
            if calculator.isValid(str: t.formattedString){
                DispatchQueue.global(qos: .background).async {
                    
                    let exressionArray = t.formattedString.getExpressionArray()
                    let result  = self.calculator.calculate(arr:exressionArray)
                    
                    DispatchQueue.main.async {
                        self.resultLabel.text = Words.resultIs.rawValue + " " + result.description
                        
                    }
                    return
                }
            }
        }
        
    }
}


