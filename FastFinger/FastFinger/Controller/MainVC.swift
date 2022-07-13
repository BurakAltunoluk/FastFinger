//
//  ViewController.swift
//  FastFinger
//
//  Created by Burak Altunoluk on 10/07/2022.
//

import UIKit

final class MainVC: UIViewController {
    
    //MARK: Properties
    var newScoreCounter = 0
    var durtion = 20
    var countTimer = Timer()
    
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var countdownTimeDisplay: UILabel!
    @IBOutlet var currentScoreDisplay: UILabel!
    @IBOutlet var buttonGestureImage: UIImageView!
    @IBOutlet var infoDisplay: UILabel!
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonGestureImage.isUserInteractionEnabled = true
        let playButtonImageGesture = UITapGestureRecognizer(target: self,
                                                            action: #selector(playButtonAction))
        buttonGestureImage.addGestureRecognizer(playButtonImageGesture)
        
    }
    
    @objc func playButtonAction() {
        progressBar.tintColor = UIColor(named: "Colordark")
        countdownTimeDisplay.alpha = 1
        infoDisplay.text = "Running..."
        buttonGestureImage.image = UIImage(named: "clickButton")
        newScoreCounter += 1
        currentScoreDisplay.text = String(newScoreCounter)
        creatTimer()
        
    }
    
    @objc func countBackwards() {
        
        durtion -= 1
        countdownTimeDisplay.text = String(durtion)
        progressBar.progress -= 0.05
        
        if durtion == 0 {
            buttonGestureImage.isUserInteractionEnabled = false
            countTimer.invalidate()
            buttonGestureImage.image = UIImage(named: "playButton")
            countdownTimeDisplay.alpha = 0
            durtion = 20
            countdownTimeDisplay.text = "20"
            infoDisplay.text = "Press play button to start..."
            performSegue(withIdentifier: "toScorePage", sender: String.self)
        }
    }
    
    func creatTimer() {
        if !countTimer.isValid {
            countTimer = Timer.scheduledTimer(timeInterval: 1,
                                            target: self,
                                            selector: #selector(countBackwards),
                                            userInfo: nil,
                                            repeats: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScorePage" {
            let destinationVC = segue.destination as! ScoreVC
            destinationVC.newScore = newScoreCounter
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}



