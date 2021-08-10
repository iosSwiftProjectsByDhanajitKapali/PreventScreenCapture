//
//  ScreenCaptureProtector.swift
//  PreventScreenCapture
//
//  Created by unthinkable-mac-0025 on 10/08/21.
//

import UIKit

class ScreenCaptureProtector {
    private var warningWindow: UIWindow?

    private var isScreenRecording : Bool = false
    
    private var window: UIWindow? {
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
    }

    func startPreventingRecording() {
        NotificationCenter.default.addObserver(self, selector: #selector(didDetectRecording), name: UIScreen.capturedDidChangeNotification, object: nil)
    }

    func startPreventingScreenshot() {
        NotificationCenter.default.addObserver(self, selector: #selector(didDetectScreenshot), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }

    @objc private func didDetectRecording() {
        DispatchQueue.main.async { [self] in
            self.hideScreen()
            self.presentwarningWindow("Screen recording is not allowed in our app!")
            
            while(isScreenRecording){
                if UIScreen.main.isCaptured {
                    window?.isHidden = true
                    isScreenRecording = true
                } else {
                    window?.isHidden = false
                    isScreenRecording = false
                }
            }
            self.removeWarningWindow()
        }
    }

@objc private func didDetectScreenshot() {
    DispatchQueue.main.async {
        self.hideScreen()
        self.presentwarningWindow( "Screenshots are not allowed in our app. Please delete the screenshot from your photo album!")
//        self.grandAccessAndDeleteTheLastPhoto()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            print("Removing warning window")
            self.removeWarningWindow()
        }
        
    }
}

    private func hideScreen() {
        if UIScreen.main.isCaptured {
            window?.isHidden = true
            isScreenRecording = true
        } else {
            window?.isHidden = false
            isScreenRecording = false
        }
    }

    private func presentwarningWindow(_ message: String) {
        // Remove exsiting
        warningWindow?.removeFromSuperview()
        warningWindow = nil

        guard let frame = window?.bounds else { return }

        // Warning label
        let label = UILabel(frame: frame)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.text = message

        // warning window
        var warningWindow = UIWindow(frame: frame)

        let windowScene = UIApplication.shared
            .connectedScenes
            .first {
                $0.activationState == .foregroundActive
            }
        if let windowScene = windowScene as? UIWindowScene {
            warningWindow = UIWindow(windowScene: windowScene)
        }

        warningWindow.frame = frame
        warningWindow.backgroundColor = .black
        warningWindow.windowLevel = UIWindow.Level.statusBar + 1
        warningWindow.clipsToBounds = true
        warningWindow.isHidden = false
        warningWindow.addSubview(label)

        self.warningWindow = warningWindow

        UIView.animate(withDuration: 0.15) {
            label.alpha = 1.0
            label.transform = .identity
        }
        warningWindow.makeKeyAndVisible()
    }
    
    private func removeWarningWindow(){
        warningWindow?.removeFromSuperview()
        warningWindow = nil
    }

    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
