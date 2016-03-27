//
//  UserDetailCollectionItemView.swift
//  HeadCoach
//
//  Created by Mitchell Johnson on 2/15/16.
//  Copyright © 2016 Group 8. All rights reserved.
//

import Foundation
import SnapKit

class UserDetailCollectionItemView: UICollectionViewCell{
    
    let text = UILabel();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        addSubview(text)
        text.snp_makeConstraints{ (make) -> Void in
            make.edges.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setText(actualText :String){
        self.text.text = actualText
    }
}

