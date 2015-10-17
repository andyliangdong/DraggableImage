//
//  CardsViewController.swift
//  TinderApp
//
//  Created by Andy (Liang) Dong on 9/23/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

  
    @IBOutlet weak var cardImageView: DraggableImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardImageView.image = UIImage(named: "ryan")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onCardTapGesture(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("profileImageViewSegue", sender: self)
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "profileImageViewSegue" {
            let dvc = segue.destinationViewController as! ProfileViewController
            dvc.image = cardImageView.image!
            dvc.modalPresentationStyle = UIModalPresentationStyle.Custom
            dvc.transitioningDelegate = self
        }
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        print("animating transition")
        let containerView = transitionContext.containerView()!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        
        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            toViewController.view.alpha = 1
            }) { (finished: Bool) -> Void in
                transitionContext.completeTransition(true)
        }
       
    }
    
}
