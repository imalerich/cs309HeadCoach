//
//  HCSetupViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/8/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCSetupViewController: UIViewController {

    let DISTANCE = CGFloat(40)
    let DURATION = NSTimeInterval(10)

    let login = HCLoginScreenViewController()
    let newAccount = HCCreateAccountViewController()

    let pagevc = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll,
                                   navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal,
                                   options: nil)

    let background0 = UIImageView()
    let background1 = UIImageView()
    let overlay = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        addBackground()
        view.addSubview(pagevc.view)
        pagevc.view.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        login.pageController = self
        newAccount.pageController = self

        pagevc.setViewControllers([login],
                           direction: UIPageViewControllerNavigationDirection.Forward,
                           animated: false, completion: nil)
    }

    // -------------------------------------------
    // Background Management
    // -------------------------------------------

    func addBackground() {
        background0.image = UIImage(named: "Stadium_0")
        background0.contentMode = .ScaleAspectFill
        background1.alpha = 1.0

        pagevc.view.insertSubview(background0, atIndex: 0)
        background0.snp_makeConstraints { (make) in
            make.top.equalTo(pagevc.view.snp_top)
            make.bottom.equalTo(pagevc.view.snp_bottom)
            make.left.equalTo(pagevc.view.snp_left).offset(-DISTANCE)
            make.right.equalTo(pagevc.view.snp_right).offset(DISTANCE)
        }

        background1.image = UIImage(named: "Stadium_1")
        background1.contentMode = .ScaleAspectFill
        background1.alpha = 0.0

        pagevc.view.insertSubview(background1, aboveSubview: background0)
        background1.snp_makeConstraints { (make) in
            make.edges.equalTo(background0)
        }

        background0.transform = CGAffineTransformMakeTranslation(-DISTANCE, 0)
        background1.transform = CGAffineTransformMakeTranslation(-DISTANCE, 0)

        overlay.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        pagevc.view.insertSubview(overlay, aboveSubview: background1)
        overlay.snp_makeConstraints { (make) in
            make.edges.equalTo(pagevc.view)
        }

        animateBackground(1)
    }

    func animateBackground(direction: CGFloat) {
        let background = direction > 0 ? background0 : background1
        let other = direction > 0 ? background1 : background0

        UIView.animateWithDuration(DURATION, animations: {
            let trans = CGAffineTransformMakeTranslation(direction * self.DISTANCE, 0)
            self.background0.transform = trans
            self.background1.transform = trans
        }) { (success) in
            UIView.animateWithDuration(1, animations: {
                background.alpha = 0.0
                other.alpha = 1.0
            }, completion: { (success) in
                self.animateBackground(-direction)
            })
        }
    }
}

