//
//  HCMiniGameViewController.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/24/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCMiniGameViewController: UIViewController {

    /// Number of background sections (each section will alternate colors).
    let BACKGROUND_SECTIONS = 6

    /// Number of white markers to add to the sides of each section.
    let MARKERS_PER_SECTION = 3

    /// Maxmimum difficulty for this mini game.
    let MIN_CYCLE_DURATION = CGFloat(0.5)

    /// The width in dp's for each marker.
    let MARKER_WIDTH = 8

    /// The length of time (in seconds) that the ball will be in the air.
    let KICK_SPEED = 0.8

    /// Go for the goal baby.
    let goalPost = UIImageView()

    /// This is what it's all about.
    let football = UIImageView()

    /// Label containing the users current score.
    let scoreLabel = UILabel()

    /// The direction the goal post needs to move.
    var postDir = 1

    /// How many seconds should be used to move the 
    /// post frome one end of the field to the other.
    /// This controls the difficulty.
    var cycleDuration = CGFloat(3.0)

    /// The time the current cycle of the goal post started on.
    var cycleStartTime = NSTimeInterval(0)

    /// Only allowed to kick while the football is 
    /// not animating.
    var isKicking = false

    /// The current score
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // setup our background view
        title = "Secret Page"
        edgesForExtendedLayout = .None
        view.backgroundColor = UIColor.footballColor(1.0)
        setupBackground()

        addGoalPost()
        addFootball()
        addScore()
    }

    /// Initialize and start animating the goal post.
    private func addGoalPost() {
        goalPost.image = UIImage(named: "goal_post")
        goalPost.contentMode = .ScaleAspectFit

        view.addSubview(goalPost)
        goalPost.snp_makeConstraints { (make) in
            make.left.equalTo(view)
            make.top.equalTo(view).offset(8)
            make.height.equalTo(200)
            make.width.equalTo(goalPost.snp_height).multipliedBy(0.813)
        }

        animatePost()
    }

    /// Add the football to the bottom of the screen.
    /// When the player taps the screen this will shoot at the goal post.
    private func addFootball() {
        football.image = UIImage(named: "football")
        football.contentMode = .ScaleAspectFit

        view.addSubview(football)
        football.snp_makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-8)
            make.centerX.equalTo(view)
            make.height.equalTo(100)
            make.width.equalTo(football.snp_height).multipliedBy(0.583)
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.kickFootball))
        view.addGestureRecognizer(tap)
    }

    /// Add the current score label.
    private func addScore() {
        scoreLabel.font = UIFont.systemFontOfSize(44, weight: UIFontWeightHeavy)
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.textAlignment = .Right
        scoreLabel.text = "\(score)"

        view.addSubview(scoreLabel)
        scoreLabel.snp_makeConstraints { (make) in
            make.bottom.right.equalTo(view).offset(-12)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
    }

    /// Updates the current difficulty of this mini game.
    private func incrementDifficulty() {
        cycleDuration = max(cycleDuration - 0.2, MIN_CYCLE_DURATION)
    }

    /// Add a point and update the score label.
    @objc private func scorePoint() {
        score += 1
        scoreLabel.text = "\(score)"
    }

    @objc private func missPoint() {
        score = 0
        scoreLabel.text = "\(score)"
        cycleDuration = CGFloat(3.0)
    }

    /// Kick the football towards the top of the screen,
    /// This method will do the necessary calculations to determine 
    /// whether or not a score was made.
    @objc private func kickFootball() {
        if isKicking {
            // the ball is already in motion
            return
        }

        isKicking = true
        checkIfScored()

        let offset = view.frame.size.height
        UIView.animateWithDuration(KICK_SPEED, animations: {
            self.football.transform = CGAffineTransformMakeTranslation(0, -offset)

        }) { (succ) in
            // fade the ball back in at the bottom of the screen
            // and reebale kicking
            self.football.alpha = 0.0
            self.football.transform = CGAffineTransformIdentity

            UIView.animateWithDuration(0.3, animations: {
                self.football.alpha = 1.0
            }, completion: { (succ) in
                self.isKicking = false
            })
        }
    }

    /// Does some simple linear interpolation at the time
    /// of kick off to determine if the ball will or will not
    /// score.
    private func checkIfScored() {
        // Height of the horizontal beam of the goal gost.
        let scoreLine = CGFloat(8 + 200 * 0.51)

        // We need to know when the ball will be at the score line.
        let dpPerSec = view.frame.size.height / CGFloat(KICK_SPEED)
        let startPos = CGFloat(view.frame.size.height - 8 - 100)
        let distToGoal = startPos - scoreLine
        let timeToGoal = NSTimeInterval(distToGoal / dpPerSec)
        let atGoalTime = NSDate(timeIntervalSinceNow: timeToGoal).timeIntervalSince1970

        // Horizontal boundig box for the ball.
        let ballWidth = CGFloat(100 * 0.583)

        // when will the goal post be within bounds for scoring
        let postWidth = CGFloat(200 * 0.8126 * 0.91)
        let minGoalBounds = CGFloat(view.frame.size.width - postWidth + ballWidth) / CGFloat(2.0)
        let maxGoalBounds = CGFloat(view.frame.size.width + postWidth - ballWidth) / CGFloat(2.0)
        let offset = self.view.frame.size.width - (200 * 0.813)
        let cycleSpeed = CGFloat(offset / cycleDuration)

        // note these calculation are performed assuming the goal post is moving left
        // but this game is symmetric about the Y axis, so this should work for 
        // when the goal post is moving right as well
        let atMinTime = cycleStartTime + NSTimeInterval(minGoalBounds / cycleSpeed)
        let atMaxTime = cycleStartTime + NSTimeInterval(maxGoalBounds / cycleSpeed)

        if atGoalTime >= atMinTime && atGoalTime <= atMaxTime {
            // wait until the ball has actually passed the bounds to update the score
            performSelector(#selector(self.missPoint), withObject: nil, afterDelay: timeToGoal)
        } else {
            // wait until the ball has actually passed the bounds to update the score
            performSelector(#selector(self.scorePoint), withObject: nil, afterDelay: timeToGoal)
            incrementDifficulty()
        }
    }

    /// Move's the post in the current 'postDir'.
    private func animatePost() {
        // Update the start time for the current travel distance.
        cycleStartTime = NSDate().timeIntervalSince1970

        // Animate the goal post to the other side of the field.
        UIView.animateWithDuration(NSTimeInterval(cycleDuration), animations: {
            if self.postDir == 1 {
                let offset = self.view.frame.size.width - (200 * 0.813)
                self.goalPost.transform = CGAffineTransformMakeTranslation(offset, 0)
            } else {
                self.goalPost.transform = CGAffineTransformIdentity
            }

        }) { (success) in
            self.postDir = -self.postDir
            self.animatePost()
        }
    }

    /// Addds the football field-esque background
    /// to this view, this method should be called
    /// once before all other views are added.
    private func setupBackground() {
        var prev = view
        for i in 1...BACKGROUND_SECTIONS {
            let bg = UIView()
            bg.backgroundColor = UIColor.footballColor(1.0 - 0.1 * CGFloat(i % 2))

            // add and layout this section
            view.addSubview(bg)
            bg.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(view)
                make.height.equalTo(view).dividedBy(BACKGROUND_SECTIONS)
                make.top.equalTo(prev == view ? prev.snp_top : prev.snp_bottom)
            })

            // add a white divider line between each view
            // exclude the bottom section
            if i != BACKGROUND_SECTIONS {
                let bottom = UIView()
                bottom.backgroundColor = UIColor.whiteColor()
                bg.addSubview(bottom)
                bottom.snp_makeConstraints(closure: { (make) in
                    make.left.right.bottom.equalTo(bg)
                    make.height.equalTo(2)
                })
            }

            addMarkersToSection(bg)
            prev = bg;
        }
    }

    /// Adds white markers to a section of the background view.
    private func addMarkersToSection(section: UIView) {
        var prev = section

        for _ in 0...(MARKERS_PER_SECTION - 1) {
            for dir in 0...1 {
                let marker = UIView()
                marker.backgroundColor = UIColor.clearColor()

                section.addSubview(marker)
                marker.snp_makeConstraints(closure: { (make) in
                    if dir == 0 {
                        make.right.equalTo(section)
                    } else {
                        make.left.equalTo(section)
                    }

                    make.height.equalTo(section).dividedBy(MARKERS_PER_SECTION + 1)
                    make.top.equalTo(prev == section ? prev.snp_top : prev.snp_bottom)
                    make.width.equalTo(MARKER_WIDTH)
                })

                // add the bottom border for each marker
                let bottom = UIView()
                bottom.backgroundColor = UIColor.whiteColor()
                marker.addSubview(bottom)
                bottom.snp_makeConstraints(closure: { (make) in
                    make.left.right.bottom.equalTo(marker)
                    make.height.equalTo(2)
                })

                // increment the prev marker when we are done with this section
                prev = dir == 1 ? marker : prev
            }
        }
    }

}
