//
//  DraggableImageView.swift
//  TinderApp
//
//  Created by Andy (Liang) Dong on 9/23/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class DraggableImageView: UIView, UIGestureRecognizerDelegate {

    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var image : UIImage? {
        didSet {
            imageView.image = image
            initialCenter = imageView.center
        }
    }
    
    var initialCenter: CGPoint?
    var clockwise = CGFloat(1)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiateWithOwner(self, options: nil)
        contentView.frame = bounds
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        addSubview(contentView)
    }
    
    
    func swipeRight() {
        print("swipe right")
    }
    
    func swipeLeft(){
        print("swipe left")
    }
   
    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        let location = sender.locationInView(self)
        let translate = sender.translationInView(self)
        let velocity = sender.velocityInView(self)
        let rotation = clockwise * (translate.x / 10).degreesToRadians
        
        if sender.state == UIGestureRecognizerState.Began {
            if location.y > initialCenter!.y {
                clockwise = CGFloat(-1)
            } else {
                clockwise = CGFloat(1)
            }
        } else if sender.state == UIGestureRecognizerState.Changed {
            imageView.center.x = initialCenter!.x + translate.x
            imageView.transform = CGAffineTransformMakeRotation(rotation)
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: CGFloat(0.6), initialSpringVelocity: CGFloat(3), options: [], animations: { () -> Void in
                    if velocity.x < 0 && translate.x < -80 {
                        self.imageView.center.x -= self.frame.width
                        self.swipeLeft()
                    } else if velocity.x > 0 && translate.x > 80 {
                        self.imageView.center.x += self.frame.width
                        self.swipeRight()
                    } else {
                        self.imageView.center = self.initialCenter!
                        self.imageView.transform = CGAffineTransformIdentity
                    }
                }, completion: { (success:Bool) -> Void in
            })
        }
    }
    
}

extension CGFloat {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}
