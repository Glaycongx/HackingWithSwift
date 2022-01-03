//
//  ViewController.swift
//  Project2
//
//  Created by Glaycon Gomes Xavier on 04/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAwnser = 0
    var askedAwnser = 0
    lazy var scoreButton =  UIBarButtonItem()
    lazy var countButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
        scoreButton = UIBarButtonItem(
            title: "SCORE: \(score)"
        )
        
        countButton = UIBarButtonItem(
            title: "ASKED: \(askedAwnser)"
        )
        
        self.navigationItem.rightBarButtonItem = scoreButton
        self.navigationItem.leftBarButtonItem = countButton
        
        scoreButton.tintColor = .black
        countButton.tintColor = .black
        navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAwnser = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAwnser].uppercased()
    }
    
    func alertWith10(){
        let ac1 = UIAlertController(title: "Game Over", message: "You answered 10 questions! End of the game. Your score is \(score)", preferredStyle: .alert)
        ac1.addAction(UIAlertAction(title: "Start new game", style: .default, handler: askQuestion))
        present(ac1, animated: true)
    }
    
    func startNewGame(){
        score = 0
        askedAwnser = 0
        countButton.title = "ASKED: \(askedAwnser)"
        scoreButton.title = "SCORE: \(score)"
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAwnser {
            title = "Correct"
            score += 1
            askedAwnser += 1
            countButton.title = "ASKED: \(askedAwnser)"
            scoreButton.title = "SCORE: \(score)"
        } else {
            title = "Wrong"
            score -= 1
            askedAwnser += 1
            if score < 0{
                score = 0
            }
            countButton.title = "ASKED: \(askedAwnser)"
            scoreButton.title = "SCORE: \(score)"
        }
        
        if askedAwnser == 10 {
            alertWith10()
            startNewGame()
        } else{
            let ac = UIAlertController(title: title, message: "Your score is \(score). This flag is the \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
}
