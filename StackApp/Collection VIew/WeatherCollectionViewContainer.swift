//
//  WeatherCollectionViewContainer.swift
//  StackApp
//
//  Created by datta on 14/07/2016.
//  Copyright © 2016 Stack Lab. All rights reserved.
//

import UIKit

class WeatherCollectionViewContainer: UIView, UICollectionViewDelegate, UICollectionViewDataSource, CustomCollectionLayoutDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // Our custom view from the XIB file
    var view: UIView!
    
    //MARK: - Initial Values
    private var _defaultCityCellHeight: CGFloat = 250
    private var _minCityCellHeight: CGFloat = 125
    
    private let _timeCellHeight: CGFloat = 100
    private let _weekCellHeight: CGFloat = 250
    private let _todayCellHeight: CGFloat = 50
    private let _summaryCellHeight: CGFloat = 250

    //MARK: - Setup
    private func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "WeatherCollectionViewContainer", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.registerNib(CityCollectionViewCell.nib(), forCellWithReuseIdentifier: CityCollectionViewCell.identifier())
        collectionView.registerNib(TimeCollectionViewCell.nib(), forCellWithReuseIdentifier: TimeCollectionViewCell.identifier())
        collectionView.registerNib(WeekCollectionViewCell.nib(), forCellWithReuseIdentifier: WeekCollectionViewCell.identifier())
        collectionView.registerNib(TodayCollectionViewCell.nib(), forCellWithReuseIdentifier: TodayCollectionViewCell.identifier())
        collectionView.registerNib(SummaryCollectionViewCell.nib(), forCellWithReuseIdentifier: SummaryCollectionViewCell.identifier())
    }
    
    //MARK: Collection View Methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        var cell: UICollectionViewCell?
        
        switch indexPath.section {
        case 0:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(CityCollectionViewCell.identifier(), forIndexPath: indexPath) as! CityCollectionViewCell
            break
        case 1:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(TimeCollectionViewCell.identifier(), forIndexPath: indexPath) as! TimeCollectionViewCell
            break
        case 2:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(WeekCollectionViewCell.identifier(), forIndexPath: indexPath) as! WeekCollectionViewCell
            break
        case 3:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(TodayCollectionViewCell.identifier(), forIndexPath: indexPath) as! TodayCollectionViewCell
            break
        case 4:
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(SummaryCollectionViewCell.identifier(), forIndexPath: indexPath) as! SummaryCollectionViewCell
            break
        default:
            assert(false)
        }
        return cell!
    }
    
    //MARK: Custom Delegates
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, shouldFloatSectionAtIndex section: Int) -> Bool {
        if section == 0 || section == 1 {
            return true
        }
        return false
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var ret = CGSize(width: collectionView.frame.width, height: 0)
        switch indexPath.section {
        case 0:
            if collectionView.contentOffset.y > 0 {
                let newHieght = _defaultCityCellHeight - collectionView.contentOffset.y
                if newHieght < _minCityCellHeight {
                    ret.height = _minCityCellHeight
                }
                else {
                    ret.height = newHieght
                }
            }
            else {
                ret.height = _defaultCityCellHeight
            }
            break
        case 1:
            ret.height = _timeCellHeight
            break
        case 2:
            ret.height = _weekCellHeight
            break
        case 3:
            ret.height = _todayCellHeight
            break
        case 4:
            ret.height = _summaryCellHeight
            break
        default:
            assert(false)
        }
        return ret
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if collectionView.contentOffset.y <= 0 {
            let firstCell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0))
            firstCell?.frame = CGRect(x: (firstCell?.frame.origin.x)!, y: collectionView.contentOffset.y, width: (firstCell?.frame.width)!, height: _defaultCityCellHeight - collectionView.contentOffset.y)
        }
    }

}
