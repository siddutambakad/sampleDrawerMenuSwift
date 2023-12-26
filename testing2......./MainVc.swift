//
//  MainVc.swift
//  testing2.......
//
//  Created by siddappa tambakad on 22/12/23.
//

import UIKit

class MainVc: UIViewController, SideMenuVcDelegate {
    
    @IBOutlet var mainVCTrailing: NSLayoutConstraint!
    @IBOutlet var mainVcLeading: NSLayoutConstraint!
    
    var sideMenuShadowView: UIView!
    var sideMenuViewController: SecondMainVc!
    var sideMenuRevealWidth: CGFloat = 260
    let paddingForRotation: CGFloat = 0
    var isExpanded: Bool = false
    var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    var draggingIsEnabled: Bool = false
    var panBaseLocation: CGFloat = 0.0
    
//    var tabBarShadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Shadow Background View
            self.sideMenuShadowView = UIView(frame: self.view.bounds)
            self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.sideMenuShadowView.backgroundColor = .black
            self.sideMenuShadowView.alpha = 0
        
//        // Shadow Background View for tableview
//            self.tabBarShadowView = UIView(frame: tabBarController?.tabBar.bounds ?? CGRect(x: 0, y: 0, width: 0, height: 0))
//            self.tabBarShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            self.tabBarShadowView.backgroundColor = .black
//            self.tabBarShadowView.alpha = 0
//            tabBarController?.tabBar.insertSubview(self.tabBarShadowView, at: 1)
//
       
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
            tapGestureRecognizer.numberOfTapsRequired = 1
            tapGestureRecognizer.delegate = self
            self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
            view.insertSubview(self.sideMenuShadowView, at: 1)
        
        // Side Menu
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SecondMainVc") as? SecondMainVc
            sideMenuViewController.delegate = self
            view.insertSubview(self.sideMenuViewController!.view, at: 10)
            addChild(self.sideMenuViewController!)
            self.sideMenuViewController!.didMove(toParent: self)
        
        // Side Menu AutoLayout
            self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.sideMenuLeadingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuLeadingConstraint.isActive = true
        
        
        NSLayoutConstraint.activate([
                self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
                self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
            ])
        
//        // Side Menu Gestures
//            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
//            panGestureRecognizer.delegate = self
//            view.addGestureRecognizer(panGestureRecognizer)
       

    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {

        toggleSideMenu(expanded: isExpanded ? false : true)
        
    }
    
    
    func toggleSideMenu(expanded: Bool) {
        if expanded {
            self.tabBarController?.tabBar.isHidden = true
            self.animateSideMenu(targetPosition: 0) { _ in
                self.isExpanded = true
            }
            self.animateShadow(alpha: 0.6)
        }
        else {
            self.tabBarController?.tabBar.isHidden = false
            self.animateSideMenu(targetPosition: (-self.sideMenuRevealWidth - self.paddingForRotation)) { _ in
                self.isExpanded = false
            }
            self.animateShadow(alpha: 0)
        }
    }
    
    func animateShadow(alpha: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.sideMenuShadowView.alpha = alpha
        }
    }

    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            self.sideMenuLeadingConstraint.constant = targetPosition
//            self.mainVcLeading.constant = targetPosition + self.sideMenuRevealWidth
//            self.mainVCTrailing.constant = targetPosition + self.sideMenuRevealWidth
//            self.tabBarController?.tabBar.frame.origin.x = targetPosition + self.sideMenuRevealWidth
            self.view.layoutIfNeeded()

        }, completion: completion)
    }
    
//    // Dragging Side Menu
//    @objc private func handleHomePagePanGesture(sender: UIPanGestureRecognizer) {
//        handlePanGesture(sender: sender)
//    }
//
//    // Dragging Side Menu
//    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
//
//        let position: CGFloat = sender.translation(in: self.view).x
//        let velocity: CGFloat = sender.velocity(in: self.view).x
//
//        switch sender.state {
//        case .began:
//
//            // cancel if the menu is expanded and drag is from left to right
//            if velocity > 0, self.isExpanded {
//                sender.state = .cancelled
//            }
//
//            // Enable dragging if menu is not expanded and drag is from left to right
//            if velocity > 0, !self.isExpanded {
//                self.draggingIsEnabled = true
//            }
//            // Enable dragging if menu is expanded and drag is from right to left
//            else if velocity < 0, self.isExpanded {
//                self.draggingIsEnabled = true
//            }
//
//            if self.draggingIsEnabled {
//                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
//                let velocityThreshold: CGFloat = 550
//                if abs(velocity) > velocityThreshold {
//                    self.toggleSideMenu(expanded: self.isExpanded ? false : true)
//                    self.draggingIsEnabled = false
//                    return
//                }
//                self.panBaseLocation = 0.0
//                if self.isExpanded {
//                    self.panBaseLocation = self.sideMenuRevealWidth
//                }
//            }
//
//        case .changed:
//            // Animate side menu along with dragging action
//            if self.draggingIsEnabled {
//                let xLocation: CGFloat = self.panBaseLocation + position
//                let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
//
//                let alpha = percentage >= 0.6 ? 0.6 : percentage
//                self.sideMenuShadowView.alpha = alpha
//
//                // Move side menu while dragging
//                if xLocation <= self.sideMenuRevealWidth {
//                    self.sideMenuLeadingConstraint.constant = xLocation - self.sideMenuRevealWidth
////                    self.mainVcLeading.constant = xLocation
////                    self.mainVCTrailing.constant = xLocation
////                    self.tabBarController?.tabBar.frame.origin.x = xLocation
//                }
//            }
//        case .ended:
//            self.draggingIsEnabled = false
//            // If the side menu is half Open/Close, then Expand/Collapse with animation
//            let movedMoreThanHalf = self.sideMenuLeadingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
//            self.toggleSideMenu(expanded: movedMoreThanHalf)
//
//        default:
//            break
//        }
//    }
//    func handleSideMenuPanGesture(_ sender: UIPanGestureRecognizer) {
//        handlePanGesture(sender: sender)
//    }
//    func dismissSecondMainVc() {
//            toggleSideMenu(expanded: false)
//        }
}

extension MainVc: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.toggleSideMenu(expanded: false)
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
}
