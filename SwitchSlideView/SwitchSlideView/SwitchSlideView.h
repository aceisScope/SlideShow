//
//  SwitchSlideView.h
//  SwitchSlideView
//
//  Created by B.H. Liu on 12-5-14.
//  Copyright (c) 2012年 Appublisher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchSlideView : UIView<UIScrollViewDelegate>

@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,readwrite) NSInteger currentIndex;
@property (nonatomic,readwrite) NSInteger totalPages;

- (void)setImagesWithArray:(NSArray*)array;

@end
