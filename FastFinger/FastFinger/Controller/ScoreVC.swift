//
//  ScoreVC.swift
//  FastFinger
//
//  Created by Burak Altunoluk on 10/07/2022.
//

import UIKit

class ScoreVC: UIViewController {
    //MARK: Properties
    var newScore = 0
    var bestScoreFromModel = ScoreModel()
    
    @IBOutlet var bestScore: UILabel!
    @IBOutlet var currentScore: UILabel!
    @IBOutlet var backButton: UIImageView!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentScore.text = "Your score: \(newScore)"
        bestScore.text = "Best score: \(bestScoreFromModel.bestScore)"
        if newScore > bestScoreFromModel.bestScore {
            UserDefaults.standard.setValue(newScore, forKey: "bestScore")
            bestScore.text = "Best score: \(newScore)"
        }
        
        backButton.isUserInteractionEnabled = true
        let backButtonGesture = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        backButton.addGestureRecognizer(backButtonGesture)
    }
    
    @objc func backToMain() {
        performSegue(withIdentifier: "toMain", sender: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
