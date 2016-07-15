//
//  TimeCollectionViewCell.swift
//  StackApp
//
//  Created by datta on 14/07/2016.
//  Copyright © 2016 Stack Lab. All rights reserved.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.registerNib(TimeDetailCollectionViewCell.nib(), forCellWithReuseIdentifier: TimeDetailCollectionViewCell.identifier())
    }

    class func identifier() -> String {
        return "TimeCollectionViewCellId"
    }
    
    class func nib() -> UINib {
        let nib = UINib(nibName: "TimeCollectionViewCell", bundle: NSBundle.mainBundle())
        return nib
    }
    
    //MARK: Collection View Methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 50, height: collectionView.frame.size.height)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(TimeDetailCollectionViewCell.identifier(), forIndexPath: indexPath) as! TimeDetailCollectionViewCell
        return cell
    }
}
