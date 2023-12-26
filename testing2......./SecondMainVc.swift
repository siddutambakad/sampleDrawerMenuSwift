//
//  SecondMainVc.swift
//  testing2.......
//
//  Created by siddappa tambakad on 22/12/23.
//

import UIKit

protocol SideMenuVcDelegate {
//    func handleSideMenuPanGesture(_ sender: UIPanGestureRecognizer )
//    func dismissSecondMainVc()
}

class SecondMainVc: UIViewController {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var myView1: UIView!
    
    var delegate: SideMenuVcDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
//                panGestureRecognizer.delegate = self
//                view.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let aboutUsVc = storyboard.instantiateViewController(withIdentifier: "settingVc") as? settingVc
        navigationController?.pushViewController(aboutUsVc!, animated: true)
//        delegate?.dismissSecondMainVc()

    }
    
    @IBAction func profileButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let aboutUsVc = storyboard.instantiateViewController(withIdentifier: "AboutUs") as? AboutUs
        navigationController?.pushViewController(aboutUsVc!, animated: true)
//        delegate?.dismissSecondMainVc()
    }

}
//extension SecondMainVc: UIGestureRecognizerDelegate {
//    // Dragging Side Menu
//    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
//        delegate?.handleSideMenuPanGesture(sender)
//
//    }
//}
