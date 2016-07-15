//
//  CityCollectionViewCell.swift
//  StackApp
//
//  Created by datta on 14/07/2016.
//  Copyright © 2016 Stack Lab. All rights reserved.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func identifier() -> String {
        return "CityCollectionViewCellId"
    }
    
    class func nib() -> UINib {
        let nib = UINib(nibName: "CityCollectionViewCell", bundle: NSBundle.mainBundle())
        return nib
    }

}
