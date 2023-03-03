//
//  ViewController.swift
//  Concentrarion
//
//  Created by Aleksej Shapran on 26. 9. 2022..

import UIKit

class ViewController: UIViewController {
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
    private func updateTouches () {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 4.0,
            .strokeColor: UIColor.black
            ]
        let attributetString = NSAttributedString(string: "Касания: \(touches)", attributes: attributes)
        touchLabel.attributedText = attributetString
    }
    
    private(set) var touches = 0 {
        didSet {
            updateTouches()
        }
    }
    
    // объявил переменную touches для того что бы считать нажатия
    // вызвал метод didSet для самообновления переменной
    
    private var emojiCollection = "🦊🐰🐋🐑🐓🐕‍🦺🐞🐖🐊🐈🐵🦩🦋🐤" // задал массив эмодзи
    
    private var emojiDictionary = [Card:String]()
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            let randomStringIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4randomExtention)
            emojiDictionary[card] = String(emojiCollection.remove(at:randomStringIndex))
        }
        return emojiDictionary[card] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
                if button.backgroundColor ==  #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) {
                    button.setTitle("OK", for: .normal)
                    button.setTitleColor(UIColor.white, for: .normal)
                } else {
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    
    @IBOutlet weak var lblMainConcentrationItem: UILabel!
    @IBOutlet weak var lblRules: UILabel!
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel! {
        didSet {
            updateTouches() // присваиваю функцию изменения при старте
        }
    }
    
    @IBAction private func buttonAction(_ sender: UIButton) {
            touches += 1 // каждому нажатию присваиваю +1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.choseCard(at: buttonIndex)
            updateViewFromModel()
        }
        
    }
    
}

extension Int {
    var arc4randomExtention: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

