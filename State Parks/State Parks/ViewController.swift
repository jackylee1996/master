//
//  ViewController.swift
//  State Parks
//
//  Created by Jackeline Lee on 9/23/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var zoomScrollView: UIScrollView!
    @IBOutlet var scrollButtons: [UIButton]!
    
    
    var parkViews = [UIView]()
    let parkModel = ParkModel()
    var imageSize : CGSize
    var pictureCount = 0
    var picArray = [UIImageView]()
    var parkNumber = 0
    var imageView = UIImageView()
    //let image : UIImage

    required init?(coder aDecoder: NSCoder) {
        imageSize = CGSize(width: 20, height: 30)
        super.init(coder: aDecoder)
    }
    
    func ParkImages(){
        
        var picture = parkModel.allPictures
        let parkNum = picture.count
        
        for i in 0...picture.count - 1{
            let currentPark = picture[i]
            var parkImage : [String]
            var _parkImage = [String]()
            var pictureView : UIImageView
            var pictureArray = [UIImageView]()
            
            // set title label's frame
            let label = UILabel()
            label.text = currentPark.name
            label.font = label.font.withSize(25)
            label.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
            label.textAlignment = .center
            label.center = CGPoint(x: UIScreen.main.bounds.width/2 + (CGFloat(i) * UIScreen.main.bounds.width), y: 30)
            for j in 1...currentPark.count{
                _parkImage.append("\(currentPark.name)0\(j)")
            }

            parkImage = _parkImage
            pictureCount = parkImage.count
            let yPosition = CGFloat(scrollView.bounds.height)
            var count = 0
            
            for k in 0..<parkImage.count {
                pictureView = UIImageView(image: UIImage(named: parkImage[k]))
                imageSize = pictureView.bounds.size
                pictureView.frame.size = scrollView.bounds.size
                pictureView.contentMode = .scaleAspectFit
                pictureArray.append(pictureView)
                pictureView.center = centerForImage(park: i, index: k)
                scrollView.addSubview(pictureView)
                
                imageView = UIImageView(image: UIImage(named: parkImage[k]))
                imageView.frame.size = zoomScrollView.bounds.size
                imageView.contentMode = .scaleAspectFit
                imageView.center = centerForImage(park: i, index: k)
                zoomScrollView.addSubview(imageView)
                zoomScrollView.bringSubview(toFront: imageView)
                
                
                //Buttons programmatically
                let leftImage = UIImage(named: "left")
                let leftButton = UIButton()
                leftButton.setImage(leftImage, for: .normal)
                leftButton.center = CGPoint(x: 0 + (CGFloat(i) * self.view.bounds.width), y: self.scrollView.bounds.height/2 + (CGFloat(count)*yPosition))
                leftButton.frame.size = CGSize(width: 50, height: 50)
                leftButton.addTarget(self, action: #selector(left(_:)), for: .touchUpInside)
                scrollView.addSubview(leftButton)
                
                let rightImage = UIImage(named: "right")
                let rightButton = UIButton()
                rightButton.setImage(rightImage, for: .normal)
                rightButton.center = CGPoint(x : self.view.bounds.width - 50 + (CGFloat(i) * self.view.bounds.width), y: self.scrollView.bounds.height/2 + (CGFloat(count)*yPosition))
                rightButton.frame.size = CGSize(width: 50, height: 50)
                rightButton.addTarget(self, action: #selector(right(_:)), for: .touchUpInside)
                scrollView.addSubview(rightButton)
                
                let upImage = UIImage(named: "up")
                let upButton = UIButton()
                upButton.setImage(upImage, for: .normal)
                
                upButton.center = CGPoint(x: self.scrollView.bounds.width/CGFloat(2) - CGFloat(25) + (CGFloat(i) * self.scrollView.bounds.width), y: 0 + ((CGFloat(count) * self.scrollView.bounds.height)))
                upButton.frame.size = CGSize(width: 50, height: 50)
                upButton.addTarget(self, action: #selector(up(_:)), for: .touchUpInside)
                scrollView.addSubview(upButton)
                
                let downImage = UIImage(named: "down")
                let downButton = UIButton()
                downButton.setImage(downImage, for: .normal)
                downButton.center = CGPoint(x: self.scrollView.bounds.width/CGFloat(2) - CGFloat(25) + (CGFloat(i) * self.scrollView.bounds.width), y: self.scrollView.bounds.height - 10 + (CGFloat(count) * self.scrollView.bounds.height - 50))
                downButton.frame.size = CGSize(width: 50, height: 50)
                downButton.addTarget(self, action: #selector(down(_:)), for: .touchUpInside)
                scrollView.addSubview(downButton)
                
                count = count + 1
                
                if k == parkImage.count-1 {
                    downButton.isHidden = true
                }
                
                if k == 0 {
                    upButton.isHidden = true
                }
                if k > 0 {
                    leftButton.isHidden = true
                    rightButton.isHidden = true
                }
                if k == 0 && i == 0 {
                    leftButton.isHidden = true
                }
                
                if k == 0 && i == (pictureCount) {
                    rightButton.isHidden = true
                }
            
                scrollView.bringSubview(toFront: upButton)
                scrollView.bringSubview(toFront: downButton)
                scrollView.bringSubview(toFront: leftButton)
                scrollView.bringSubview(toFront: rightButton)
            }
            picArray = pictureArray
            parkNumber = parkNum
            scrollView.addSubview(label)
            scrollView.bringSubview(toFront: label)
        }
    }
    
    func centerForImage(park: Int, index: Int) -> CGPoint{
        let scrollViewSize = scrollView.bounds.size
        var imageCenter = CGPoint(x: scrollViewSize.width/2.0 + (scrollViewSize.width * CGFloat(park)) , y: scrollViewSize.height/2.0  + (scrollViewSize.height * CGFloat(index)))
        let scrollViewCenter = scrollView.center
        
                if (scrollView.contentSize.width < scrollViewSize.width) {
                    imageCenter.x = scrollViewCenter.x;
                }
        
                if (scrollView.contentSize.height < scrollViewSize.height) {
                    imageCenter.y = scrollViewCenter.y;
                }
        return imageCenter
    }
    
    func centerForImage() -> CGPoint {
        var imageCenter = CGPoint(x: scrollView.contentSize.width/2.0,
                                  y: scrollView.contentSize.height/2.0)
        
        let scrollViewSize = scrollView.bounds.size
        let scrollViewCenter = scrollView.center
        
        if (scrollView.contentSize.width < scrollViewSize.width) {
            imageCenter.x = scrollViewCenter.x;
        }
        
        if (scrollView.contentSize.height < scrollViewSize.height) {
            imageCenter.y = scrollViewCenter.y;
        }
        return imageCenter
    }
    
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = false
        //zoomScrollView.addSubview(imageView)
        let size = self.view.bounds.size
        scrollView.contentSize = CGSize(width: size.width * 6 , height: size.height * 5.0)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        zoomScrollView.minimumZoomScale = 0.1
        zoomScrollView.maximumZoomScale = 10.0
        zoomScrollView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        ParkImages()
        let size = self.view.bounds.size
        zoomScrollView.contentSize = CGSize(width: size.width * CGFloat(parkNumber), height: size.height * CGFloat(pictureCount + 1))
        zoomScrollView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        zoomScrollView.minimumZoomScale = 0.1
        zoomScrollView.maximumZoomScale = 10.0

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    func scaleFor(size:CGSize) -> CGFloat {
//            let viewSize = scrollView.bounds.size
//            let widthScale = viewSize.width/size.width
//            let heightScale = viewSize.height/size.height
//
//        return min(widthScale,heightScale)
//    }
    
//    //MARK: - ScrollView Delegate Methods
//    func scrollViewDidEndDecelerating(_ scrollParkView: UIScrollView) {
//        if scrollParkView == scrollView{
//            let park = 0;
//            let parkNumPics = parkModel.allPictures[park].count
//            scrollView.contentSize.height = CGFloat(parkNumPics) * scrollView.bounds.height
//            for _ in 1...parkNumPics {
//                scrollButtons[2].isHidden = true
//                scrollButtons[3].isHidden = true
//            }
//        }
//    }
    
    //MARK: Zooming
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.view.bringSubview(toFront: zoomScrollView)
        return imageView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        imageView.isHidden = false
        self.scrollView.isHidden = true
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.view.bringSubview(toFront: scrollView)
        imageView.isHidden = true
        self.scrollView.isHidden = false
    }
    
    //MARK: Arrow Actions
    @IBAction func up(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.scrollView.contentOffset.y -=  self.scrollView.bounds.height
            self.zoomScrollView.contentOffset.y -=  self.zoomScrollView.bounds.height
            
        }
    }
    
    @IBAction func down(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.scrollView.contentOffset.y +=  self.scrollView.bounds.height
            self.zoomScrollView.contentOffset.y +=  self.zoomScrollView.bounds.height

        }
    }
    
    @IBAction func right(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.scrollView.contentOffset.x +=  self.scrollView.bounds.width
            self.zoomScrollView.contentOffset.x +=  self.zoomScrollView.bounds.width

        }
    }
    
    @IBAction func left(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.scrollView.contentOffset.x -=  self.scrollView.bounds.width
            self.zoomScrollView.contentOffset.x -=  self.zoomScrollView.bounds.width

        }
    }
    
}

