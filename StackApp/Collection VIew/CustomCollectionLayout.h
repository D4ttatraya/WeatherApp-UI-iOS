//
//  CustomCollectionLayout.h
//  StackApp
//
//  Created by datta on 14/07/2016.
//  Copyright © 2016 Stack Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCollectionLayoutDelegate <UICollectionViewDelegateFlowLayout>
@optional
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout shouldFloatSectionAtIndex:(NSInteger)section;

@end

@interface CustomCollectionLayout : UICollectionViewFlowLayout

@end
