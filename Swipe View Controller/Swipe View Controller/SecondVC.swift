//
//  SecondVC.swift
//  Swipe View Controller
//
//  Created by YAUHENI IVANIUK on 9/21/18.
//  Copyright © 2018 Yauheni Ivaniuk. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    
    enum Constants {
        static let topSpace: CGFloat = 16
        static let cornerRadius: CGFloat = 12
    }
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var downIndicator: UIView!
    
    @IBOutlet weak var topConstrForMainView: NSLayoutConstraint!
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        addGesture()
    }
    
    func setViews() {
        mainView.layer.cornerRadius = Constants.cornerRadius
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
        mainView.layer.shadowOpacity = 0.8
        mainView.layer.shadowRadius = 5.0
        mainView.layer.shadowOffset = .zero
        
        downIndicator.layer.cornerRadius = downIndicator.bounds.height / 2
    }
    
    func addGesture() {
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(panGestureHandler))
        mainView.addGestureRecognizer(panGesture)
    }
    
    @IBAction func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        let movePoint = touchPoint.y - initialTouchPoint.y
        
        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            if movePoint > 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.topConstrForMainView.constant = movePoint
                    self.view.layoutIfNeeded()
                })
            }
        case .ended, .cancelled:
            if movePoint > self.view.frame.height / 3 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.5,
                               delay: 0, usingSpringWithDamping: 0.7,
                               initialSpringVelocity: 0.0,
                               options: .curveEaseOut,
                               animations: {
                                self.topConstrForMainView.constant = Constants.topSpace
                                self.view.layoutIfNeeded()
                }, completion: nil)
            }
        default:
            break
        }
    }
    
    
}
