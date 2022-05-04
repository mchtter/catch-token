//
//  ViewController.swift
//  CatchCoin
//
//  Created by Mücahit Alperen Eryılmaz on 29.10.2021.
//

import UIKit

class ViewController: UIViewController {
    UIViewController.
    
    var timer = Timer()
    var timerCharacter = Timer()
    var counter = 0
    var score = 0
    var highscore = 0
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var gameIsStarted = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let highscoreStored = UserDefaults.standard.object(forKey: "highscore")
        if highscoreStored == nil {
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        if let newScore = highscoreStored as? Int {
            highscore = newScore
            highscoreLabel.text = "Highscore: \(highscore)"
        }

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let welcomeAlert = UIAlertController(title: "Welcome", message: "If you want to start game tap start button", preferredStyle: UIAlertController.Style.alert)
        
        let startButton = UIAlertAction(title: "Start Game", style: .default) { UIAlertAction in
            self.startGame()
        }
            welcomeAlert.addAction(startButton)
        self.present(welcomeAlert, animated: true, completion: nil)
    }
    
    func startGame() {
        counter = 10
         timerLabel.text = String(counter)
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
        timerCharacter = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(timerChar), userInfo: nil, repeats: true)
    }
    
    @objc func timerChar() {
        imageOverview()
    }
    
    @objc func timerFunc() {
        timerLabel.text = String(counter)
        counter -= 1
        
        if counter < 0 {
            timer.invalidate()
            timerCharacter.invalidate()
            timerLabel.text = "Time's Over"
            
           if score > highscore {
                
               highscore = score
               highscoreLabel.text = "Highscore: \(highscore)"
               
               UserDefaults.standard.set(highscore, forKey: "highscore")
                
            }
            
            let restartAlert = UIAlertController(title: "Time's Over", message: "If you want to restart game tap restart button", preferredStyle: UIAlertController.Style.alert)
            let restartButton = UIAlertAction(title: "Restart", style: .default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.startGame()
            }
            
            restartAlert.addAction(restartButton)
            self.present(restartAlert, animated: true, completion: nil)
        }
    }

    func imageOverview() {
        let chiliz = UIImage(named: "chz")
        let imageView = UIImageView(image: chiliz!)
        
        let randomY = Int.random(in: 200...700)
        let randomX = Int.random(in: 0...310)
        
        imageView.frame = CGRect(x: randomX, y: randomY , width: 100, height: 100)
        view.addSubview(imageView)
        
        imageView.isUserInteractionEnabled = true
        
        let clickedImage = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        imageView.addGestureRecognizer(clickedImage)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            imageView.removeFromSuperview()
        }
    }
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = String("Score: \(score)")
        
    }
    
    
    
    
}

