//
//  ViewController.swift
//  Pentomino
//
//  Created by Jackeline Lee on 9/9/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

extension UIImageView {

    convenience init(pieces name:String){
        let image = UIImage(named: name)
        self.init(image: image)
        self.frame = CGRect.zero
        self.contentMode = UIViewContentMode.scaleAspectFit
        self.autoresizingMask = [UIViewAutoresizing.flexibleWidth,.flexibleHeight]
    }
    static func pieces(named name:String) -> UIImageView{
        let image = UIImage(named: name)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect.zero
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, .flexibleHeight]
        return imageView
    }
}
class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mainboard: UIImageView!
    
    @IBOutlet var appView: UIView!
    @IBOutlet var Buttons: [UIButton]!
    @IBOutlet weak var piecesBoard: UIView!
    
    
    let piece = Pieces()
    let solution = SolutionModel()
    let numberOfViews : Int
    let piecesView : [String: UIImageView]
    let numberOfRows = 2
    let numberOfColumns = 6
    var board = -1
    let kAnimationInterval = 1.0
    let kMoveScaleFactor : CGFloat = 1.2
    let kEatScaleFactor : CGFloat = 1.25
    
    var mainTap : UITapGestureRecognizer!
    //MARK: Initialization
    
    required init?(coder aDecoder: NSCoder){
        
        numberOfViews = numberOfRows * numberOfColumns
        var _piecesViews = [String: UIImageView]()
        for i in 0..<numberOfViews{
            let aView = UIImageView(image: UIImage(named: piece.pieceName(index: i)))
            let letter = piece.pieceLetter(index: i)
            _piecesViews[letter] = aView
        }
        piecesView = _piecesViews
        
        
        
        super.init(coder: aDecoder)
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainboard.isUserInteractionEnabled = true
        self.mainboard.image = UIImage(named: "Board0")
        if self.mainboard.image == UIImage(named: "Board\(0)"){
            for i in 6..<8 {
                Buttons[i].isEnabled = false
            }
        }
        loadTiles()

    }
    
    //MARK: Gesture Recognizer Actions
    
    @objc func oneTap(_ sender: UITapGestureRecognizer){
        let movingPiece = sender.view!
        movingPiece.transform = movingPiece.transform.rotated(by: CGFloat(Float.pi/2))
    }
    
    @objc func twoTaps(_ sender: UITapGestureRecognizer){
        let movingPiece = sender.view!
        movingPiece.transform = movingPiece.transform.scaledBy(x: -1, y: 1)
    }
    
    @objc func movePiece(_ sender: UIPanGestureRecognizer){
        let movingPiece = sender.view!
        self.mainboard.bringSubview(toFront: movingPiece)
        let point = sender.location(in: appView)
        movingPiece.center = point

        piecesBoard.convert(movingPiece.bounds.origin, to: mainboard)
        appView.addSubview(movingPiece)
        
        if (sender.state == UIGestureRecognizerState.ended){
            let checking = checkPieceBound(frame: movingPiece.frame)
            if checking == true {
                let piecePosition = appView.convert(movingPiece.frame.origin, to: mainboard)
                let remainderX = remainderf(Float(piecePosition.x), 30.0)
                let remainderY = remainderf(Float(piecePosition.y), 30.0)
                if (remainderX != 0){
                    movingPiece.frame.origin.x = piecePosition.x - CGFloat(remainderX)
                }
                if (remainderY != 0){
                    movingPiece.frame.origin.y = piecePosition.y - CGFloat(remainderY)
                }
                mainboard.addSubview(movingPiece)
                self.mainboard.bringSubview(toFront: sender.view!)
                
            }

        }
    }
    
    func checkPieceBound (frame: CGRect) -> Bool {
        let checkX = frame.origin.x > mainboard.frame.origin.x && (frame.origin.x + frame.width) < (mainboard.frame.origin.x + 420)
        let checkY = frame.origin.y > mainboard.frame.origin.y && (frame.origin.y + frame.height) < (mainboard.frame.origin.y + 420)
        return (checkX && checkY)
         
    }
    
    
//        if piecesBoard.frame.contains(point){
//            self.piecesBoard.bringSubview(toFront: sender.view!)
//        }
//
//        switch sender.state{
//        case .began:
//            movingPiece.transform = CGAffineTransform(scaleX: kMoveScaleFactor, y: kMoveScaleFactor)
//            self.view.bringSubview(toFront: movingPiece)
//        case .changed:
//            let location = sender.location(in: self.view)
//            movingPiece.center = location
//        case .ended:
//            movingPiece.transform = CGAffineTransform.identity
//        default:
//            break
//        }
//
    
    //MARK: Display tiles
    fileprivate func loadTiles() {
        var i = 0
        for bView in piecesView.values {
            let height = bView.bounds.height
            let width = bView.bounds.width
            let spacing = 120
            let x = CGFloat(i % numberOfColumns) * CGFloat(spacing)
            let y = CGFloat(i / numberOfColumns) * CGFloat(spacing)
            let frame = CGRect(x: x, y: y, width: width, height: height)
            bView.frame = frame
            self.piecesBoard.addSubview(bView)
            i += 1
            
            //One Tap
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.oneTap))
            singleTap.numberOfTapsRequired = 1
            bView.addGestureRecognizer(singleTap)
            bView.isUserInteractionEnabled = true
            
            //Two Taps
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.twoTaps))
            doubleTap.numberOfTapsRequired = 2
            bView.addGestureRecognizer(doubleTap)
            singleTap.require(toFail: doubleTap)
            
            let moveTile = UIPanGestureRecognizer(target: self, action: #selector(ViewController.movePiece(_:)))
            bView.addGestureRecognizer(moveTile)
            
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //loadTiles()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Displaying Boards
    @IBAction func displayBoard(_ sender: UIButton) {
        self.mainboard.image = UIImage(named: "Board\(sender.tag)")
        if self.mainboard.image == UIImage(named: "Board\(0)"){
            for i in 6..<8 {
                Buttons[i].isEnabled = false
            }
        }
        else {
            enableButtons()
        }
        board = sender.tag - 1
        
    }
    //MARK: Buttons
    @IBAction func hint(_ sender: Any) {
        
        
    }
    
    
    
    @IBAction func solve(_ sender: Any) {
        disableButtons()
        let pixel = 30
        if board >= 0{
            for (letter, solution) in solution.allSolutions[board]{
                if let view = piecesView[letter]{
                    let x = solution.x * pixel
                    let y = solution.y * pixel
                    let rotations = solution.rotations
                    let isFlipped = solution.isFlipped
                    
                    
                    //looked up transform identity online
                    var transformations = CGAffineTransform.identity
                    transformations = transformations.rotated(by: CGFloat(rotations) * (CGFloat.pi/2.0))
                    if(isFlipped){
                        transformations = transformations.scaledBy(x: -1, y: 1)
                    }
                    
                    view.transform = transformations
                    view.frame.origin = CGPoint(x: x, y: y)
                    self.mainboard.addSubview(view)
                    
                }
            }
        }
    }
    
    
    @IBAction func reset(_ sender: Any) {
        
        
//        for (letter, solution) in solution.allSolutions[board]{
//            if let view = piecesView[letter]{
//
//
//                //looked up transform identity online
//                var transformations = CGAffineTransform.identity
//
//
//            }
//        }
        
        for bView in piecesView.values{
            //let dropDistance = self.mainboard.bounds.size.height
            let newOrigin = piecesBoard.convert(bView.frame.origin, from: mainboard)
            bView.frame.origin = newOrigin
            //let newPoint = CGPoint(x: CGFloat(), y: CGFloat())
            piecesBoard.addSubview(bView)
            UIView.animate(withDuration: kAnimationInterval) {
                bView.transform = CGAffineTransform.identity
                
            }
            
        }
        self.loadTiles()
        enableButtons()
    }
    
    func moveView(_ view: UIView, toSuperview superView: UIView){
        let newCenter = superView.convert(view.center, from: view.superview)
        view.center = newCenter
        superView.addSubview(view)
    }
    
    fileprivate func disableButtons() {
        for i in 0..<8 {
            Buttons[i].isEnabled = false
        }
    }
    
    fileprivate func enableButtons() {
        for i in 0...8 {
            Buttons[i].isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let hintViewController = segue.destination as! HintViewController
        hintViewController.index = board + 1
    }
    
    
}

