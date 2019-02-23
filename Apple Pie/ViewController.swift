//
//  ViewController.swift
//  Apple Pie
//
//  Created by student9 on 2/17/19.
//  Copyright © 2019 Erica Bermudez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["chipmunk", "yoga", "running", "dog", "coding", "pirates", "bird", "chips", "hummus", "tree", "flower", "river", "sun", "cycling", "frog", "squirrel", "amazing", "genius", "sunflower", "anime", "pizza"]
    
    let incorrectMovesAllowed = 7

    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

     var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    
    
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }


    
@IBAction func buttonPressed(_ sender: UIButton) {
    sender.isEnabled = false
    let letterString = sender.title(for: .normal)!
    let letter = Character(letterString.lowercased())
    currentGame.playerGuessed(letter: letter)
    updateGameState()
    }
}
