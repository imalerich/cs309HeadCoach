//
//  HCPositionMenu.swift
//  HeadCoach
//
//  Created by Joseph Young on 4/12/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit
import SnapKit
import ActionSheetPicker_3_0

class HCPositionMenu : UIView {
    
    var label = UILabel()
    var button = UIButton()
    var position = Position.QuarterBack
    let OFFSET = 8

    var listVC: HCPlayerListViewController? = nil

    override init(frame: CGRect){
        super.init(frame: frame)
        self.clipsToBounds = true
        backgroundColor = UIColor.footballColor(0.6)
        
        initViews()
        layoutViews()
    }
    
    internal func initViews(){
        label.font = UIFont.systemFontOfSize(22, weight: UIFontWeightLight)
        label.textColor = UIColor.whiteColor()
        label.text = HCPositionUtil.positionToString(position)
        label.textAlignment = .Left
        
        button.setTitle("Change", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.addTarget(self, action: #selector(self.changePosition), forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.footballColor(1.0)
        button.layer.cornerRadius = 6
    }
    
    internal func layoutViews(){
        addSubview(label)
        label.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(snp_left).offset(OFFSET)
            make.width.equalTo(snp_width).multipliedBy(2/3.0)
        }
        
        addSubview(button)
        button.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(OFFSET)
            make.bottom.equalTo(self).offset(-OFFSET)
            make.right.equalTo(snp_right).offset(-OFFSET)
            make.width.equalTo(90)
        }
    }

    func changePosition() {
        if let list = listVC {
            var positions = [Position]()
            var names = [String]()

            // get the array of positions to select from
            for key in list.players.keys {
                let pos = HCPositionUtil.stringToPosition(key)

                // ignore the bench position
                if pos == Position.Bench {
                    continue
                }

                names.append(HCPositionUtil.positionToName(pos))
                positions.append(pos)
            }

            // find the currently selected index
            let idx = positions.indexOf(list.currentPosition)!

            ActionSheetStringPicker.showPickerWithTitle("Filter to Position", rows: names, initialSelection: idx, doneBlock: { (picker, row, str) in
                list.setCurrentPosition(positions[row])
            }, cancelBlock: nil, origin: button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
