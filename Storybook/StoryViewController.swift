//
//  StoryViewController.swift
//  Storybook
//
//  Created by APPLE on 2020/11/17.
//

import UIKit
import AVFoundation

class StoryViewController: UIViewController {
    
    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var storyContent: UITextView!
    @IBOutlet weak var readBtn: UIButton!
    @IBOutlet weak var langSwitch: UISegmentedControl!
    
    var speechUtterance = AVSpeechUtterance(string: "")
    let synthesizer = AVSpeechSynthesizer()
    
    var lang:String = "zh-TW"
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    // MARK: - Synthesizer control
    
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
    }
    func pauseSpeaking()  {
        synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
    }
    func continueSpeaking() {
        synthesizer.continueSpeaking()
    }
    
    // MARK: - Action
    @IBAction func readBtnPressed(_ sender: Any) {
        
        readBtn.setTitle("Stop Reading", for: UIControl.State.normal)
        
        if (synthesizer.isPaused) {
            
            synthesizer.continueSpeaking()
            
        }else if (synthesizer.isSpeaking) {
            
            synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
            readBtn.setTitle("Read for me", for: UIControl.State.normal)
            
        }else{
            speechUtterance = AVSpeechUtterance(string: storyContent.text!)
            speechUtterance.voice = AVSpeechSynthesisVoice(language: lang)
            speechUtterance.rate = 0.5
            synthesizer.speak(speechUtterance)
            
        }
        
    }
    
    @IBAction func segmentDidSwitch(_ sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 0) {
            lang = "zh-TW"
        }else{
            lang = "zh-HK"
        }
        
        if (synthesizer.isSpeaking) {
            
            let alert = UIAlertController.init(title: "語系轉換", message: "閱讀停止，請重新點擊閱讀鍵", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            readBtn.setTitle("Read for me", for: UIControl.State.normal)
            
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
