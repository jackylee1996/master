//
//  ViewController.swift
//  MultiplicationApp
//
//  Created by Jackeline Lee on 8/25/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet var background: UIView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var rightOrWrong: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var possibleAnswers: UISegmentedControl!
    @IBOutlet weak var titleBackground: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var appTitle: UILabel!
    
    
    var valueA = Int()
    var valueB = Int()
    var answer = Int()
    var questionNum = Int()
    var wrong1 = Int()
    var wrong2 = Int()
    var wrong3 = Int()
    var lowerBound = Int()
    var upperBound = Int()
    var answerArray = [Int]()
    var wrongAnswerArray = [Int]()
    var disabled = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        question.isHidden = true
        questionNumber.isHidden = true
        rightOrWrong.isHidden = true
        startButton.isHidden = false
        hintButton.isHidden = true
        resetButton.isHidden = true
        nextButton.isHidden = true
        possibleAnswers.isHidden = true
        appTitle.numberOfLines = 2
        appTitle.text = "MULTIPLICATION APP"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func start(_ sender: UIButton) {
        if questionNum != 5{
            resetButton.isHidden = true
        }
        for i in 0...3{
            possibleAnswers.setEnabled(true, forSegmentAt: i)
        }
        possibleAnswers.selectedSegmentIndex = -1
        startButton.isHidden = true
        hintButton.isHidden = false
        rightOrWrong.isHidden = true
        questionNumber.isHidden = false
        question.isHidden = false
        possibleAnswers.isHidden = false
        valueA = Int(arc4random_uniform(15)) + 1
        valueB = Int(arc4random_uniform(15)) + 1
        questionNum = 1
        answer = valueA * valueB
        answerArray.insert(answer, at: 0)
        lowerBound = answer - 5
        upperBound = answer + 5
        question.text = "\(valueA) X \(valueB) = ?"
        
        generateRandomNumber()
        
        questionNumber.text = "\(questionNum) out of 5 questions"
        
    }
    
    @IBAction func hint(_ sender: AnyObject) {
        var wrongIndex = Int()
        wrongIndex = Int(arc4random_uniform(3))
      
        while possibleAnswers.titleForSegment(at: wrongIndex) == String(answer) || possibleAnswers.isEnabledForSegment(at: wrongIndex) == false {
            wrongIndex = Int(arc4random_uniform(3))
        }
        possibleAnswers.setEnabled(false, forSegmentAt: wrongIndex)
        disabled = disabled + 1
        
        if disabled == 2 {
            hintButton.isHidden = true
        }
    }
    
    @IBAction func selectingAnswer(_ sender: UISegmentedControl) {
        let selectedAnswer = possibleAnswers.titleForSegment(at: sender.selectedSegmentIndex)
        if (selectedAnswer == String(answer)) {
            if questionNum == 5 {
                question.text = "\(valueA) X \(valueB) = \(answer)"
                rightOrWrong.isHidden = false
                rightOrWrong.numberOfLines = 2
                hintButton.isHidden = true
                rightOrWrong.text = "Correct! Congratulations!"
                resetButton.isHidden = false
                
            }
            else {
                question.text = "\(valueA) X \(valueB) = \(answer)"
                rightOrWrong.textColor = UIColor.green
                rightOrWrong.isHidden = false
                rightOrWrong.text = "Correct!"
                hintButton.isHidden = true
                nextButton.isHidden = false
            }
        }
        else {
            rightOrWrong.textColor = UIColor.red
            rightOrWrong.text = "Incorrect!"
            rightOrWrong.isHidden = false
            hintButton.isHidden = true
            questionNum = 0
            nextButton.isHidden = false
            
        }
    }
    
    @IBAction func reset(_ sender: AnyObject) {
        possibleAnswers.selectedSegmentIndex = -1
        for i in 0...3{
            possibleAnswers.setEnabled(true, forSegmentAt: i)
        }
        question.isHidden = true
        hintButton.isHidden = true
        questionNumber.isHidden = true
        rightOrWrong.isHidden = true
        startButton.isHidden = false
        resetButton.isHidden = true
        nextButton.isHidden = true
        possibleAnswers.isHidden = true
        
    }
    @IBAction func next(_ sender: AnyObject) {
        if questionNum >= 5{
            resetButton.isHidden = true
        }
        for i in 0...3{
            possibleAnswers.setEnabled(true, forSegmentAt: i)
        }
        possibleAnswers.selectedSegmentIndex = -1
        disabled = 0
        hintButton.isHidden = false
        questionNum = questionNum + 1
        startButton.isHidden = true
        rightOrWrong.isHidden = true
        questionNumber.isHidden = false
        question.isHidden = false
        possibleAnswers.isHidden = false
        valueA = Int(arc4random_uniform(16)) + 1 //did not edit this magic number, I'm not sure the meaning of magic number. Here I am generating numbers from 0-15, but adding 1 to not start from 0
        valueB = Int(arc4random_uniform(16)) + 1
        answer = valueA * valueB
        answerArray.append(answer)
        lowerBound = answer - 5
        upperBound = answer + 5
        question.text = "\(valueA) X \(valueB) = ?"
        
        generateRandomNumber()
        nextButton.isHidden = true
        questionNumber.text = "\(questionNum) out of 5 questions"
        
        
    }
    func generateRandomNumber() {
        for _ in 0...2{
            var random = Int()
            repeat {
                random = Int(arc4random_uniform(UInt32(upperBound - lowerBound)) + UInt32(lowerBound))
            } while (random <= 0)
            repeat {
                random = Int(arc4random_uniform(UInt32(upperBound - lowerBound)) + UInt32(lowerBound))
            } while answerArray.contains(random)
            answerArray.append(random)
        }
        
        for i in 0...3 {
            let randomIndex = Int(arc4random_uniform(UInt32(answerArray.count)))
            possibleAnswers.setTitle(String(answerArray[randomIndex]), forSegmentAt: i)
            answerArray.remove(at: randomIndex)
        }
        
    }
    
}

