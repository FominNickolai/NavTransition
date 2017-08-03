//
//  RotateTransitionAnimator.swift
//  NavTransition
//
//  Created by Fomin Mykola on 8/3/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class RotateTransitionAnimator: NSObject {
    let duration = 0.5
    var isPresenting = false
}

extension RotateTransitionAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}

extension RotateTransitionAnimator: UIViewControllerTransitioningDelegate {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //Get reference to our fromView, toView and the container view
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        //Set up the transform we'll use in the animation
        let container = transitionContext.containerView
        //Set up the transform for rotation
        //The angle is in radian. To convert from degree to radian, use this formula
        //radian = angle * pi / 180
        let rotateOut = CGAffineTransform(rotationAngle: -90 * CGFloat.pi / 180)
        //Change the anchor point and position
        toView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        fromView.layer.anchorPoint = CGPoint(x: 0, y: 0)
        toView.layer.position = CGPoint(x: 0, y: 0)
        fromView.layer.position = CGPoint(x: 0, y: 0)
        
        //Change the initial position of the toView
        toView.transform = rotateOut
        
        //Add both views to the container view
        container.addSubview(toView)
        container.addSubview(fromView)
        
        //Perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            if self.isPresenting {
                fromView.transform = rotateOut
                fromView.alpha = 0
                toView.transform = CGAffineTransform.identity
                toView.alpha = 1.0
            } else {
                fromView.alpha = 0
                fromView.transform = rotateOut
                toView.alpha = 1.0
                toView.transform = CGAffineTransform.identity
            }
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}









