//
//  ViewController.swift
//  FastFinger
//
//  Created by Burak Altunoluk on 10/07/2022.
//

import UIKit

final class MainVC: UIViewController {
    
    //MARK: Properties
    private var newScoreCounter = 0
    private var duration = Constants.Duration
    private var countTimer = Timer()
    
    @IBOutlet private var progressBar: UIProgressView!
    @IBOutlet private var countdownTimeDisplay: UILabel!
    @IBOutlet private var currentScoreDisplay: UILabel!
    @IBOutlet private var buttonGestureImage: UIImageView!
    @IBOutlet private var infoDisplay: UILabel!
    
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
        
       // guard let intDuration = duration as? Int else { return }
                
        duration -= 1
        countdownTimeDisplay.text = String(Int(duration))
        progressBar.progress -= Constants.Progress
        
        if duration == 0 {
            buttonGestureImage.isUserInteractionEnabled = false
            countTimer.invalidate()
            buttonGestureImage.image = UIImage(named: "playButton")
            countdownTimeDisplay.alpha = 0
            duration = Constants.Duration
            countdownTimeDisplay.text = "\(Constants.Duration)"
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



