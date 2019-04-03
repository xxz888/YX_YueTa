//
//  YTUploadImageFlowLayout.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTUploadImageFlowLayout.h"

@implementation YTUploadImageFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = CGSizeMake(kRealValue(70) , kRealValue(70));
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.sectionInset = UIEdgeInsetsMake(0, kRealValue(26), 0, kRealValue(26));
    
    self.minimumInteritemSpacing = kRealValue(5);
    self.minimumLineSpacing = kRealValue(5);
}

@end
