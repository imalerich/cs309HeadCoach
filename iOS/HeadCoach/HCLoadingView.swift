//
//  HCLoadingView.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/9/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCLoadingView: UIView {

    let ANIMATION_DURATION = NSTimeInterval(0.5)
    let details = UILabel()
    let activity = UIActivityIndicatorView(activityIndicatorStyle: .White)

    init(info: String) {
        super.init(frame: CGRectMake(0, 0, 0, 0))

        backgroundColor = UIColor(white: 0.0, alpha: 0.8)

        details.textColor = UIColor.whiteColor()
        details.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        details.textAlignment = .Center
        details.numberOfLines = 0
        details.text = info

        addSubview(details)
        details.snp_makeConstraints { (make) in
            make.left.equalTo(snp_left).offset(40)
            make.right.equalTo(snp_right).offset(-40)
            make.centerY.equalTo(snp_centerY)
            make.height.equalTo(40)
        }

        addSubview(activity)
        activity.snp_makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(self.activity.snp_width)
            make.top.equalTo(self.details.snp_bottom).offset(16)
            make.centerX.equalTo(snp_centerX)
        }

        activity.startAnimating()
    }

    /// Presents this view to the top of the view stack
    /// of the 'parent' view, if 'animated' is set, 
    /// a fade animation will be used for presentation.
    internal func present(parent: UIView, animated: Bool) {
        self.alpha = 0.0
        if animated {
            UIView.animateWithDuration(ANIMATION_DURATION, animations: {
                self.alpha = 1.0
            }, completion: { (success) in
                self.addAndLayout(parent)
            })

        } else {
            addAndLayout(parent)
        }
    }

    /// Adds this view to the 'parent' view and
    /// performs the auto-layout operations necessary.
    private func addAndLayout(parent: UIView) {
        parent.addSubview(self)
        self.snp_makeConstraints { (make) in
            make.edges.equalTo(parent)
        }
    }

    /// Dismisses the loading view.
    /// If 'animated' is true, this will
    /// be dismissed with a fade animation.
    internal func dismiss(animated: Bool) {
        activity.stopAnimating()

        if animated {
            UIView.animateWithDuration(ANIMATION_DURATION, animations: {
                self.alpha = 0.0
            }, completion: { (success) in
                self.removeFromSuperview()
            })

        } else {
            removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
