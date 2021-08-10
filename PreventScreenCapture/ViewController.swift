//
//  ViewController.swift
//  PreventScreenCapture
//
//  Created by unthinkable-mac-0025 on 10/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //ScreenCaptureProtector(withObserver: self).startPreventingScreenshot()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(didTakeScreenshot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        
        //NotificationCenter.default.addObserver(self, selector: #selector(didDetectRecording), name: UIScreen.capturedDidChangeNotification, object: nil)
        
        
    }
    
   
}

extension ViewController{
//    @objc func didTakeScreenshot() -> Void {
//        print("Screen Shot Taken")
//    }
//
//    @objc func didDetectRecording() -> Void{
//        print("Screen Recording Started")
//    }
}

