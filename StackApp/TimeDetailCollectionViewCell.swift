//
//  TimeDetailCollectionViewCell.swift
//  StackApp
//
//  Created by datta on 15/07/2016.
//  Copyright © 2016 Stack Lab. All rights reserved.
//

import UIKit

class TimeDetailCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func identifier() -> String {
        return "TimeDetailCollectionViewCellId"
    }
    
    class func nib() -> UINib {
        let nib = UINib(nibName: "TimeDetailCollectionViewCell", bundle: NSBundle.mainBundle())
        return nib
    }

}
