//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Min Zheng on 3/25/15.
//  Copyright (c) 2015 Min Zheng. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            // faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness: "))
        }
    }
    
    private struct Constants{
        static let HappinessGestureScale: CGFloat = 4
    }
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state{
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
   
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
    
    var happiness: Int = 70 { // 0 = very sad, 100 = ecstatic
        didSet{
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }
    
    func updateUI(){
        faceView?.setNeedsDisplay()
        title = "\(happiness)"
    }
    
}
