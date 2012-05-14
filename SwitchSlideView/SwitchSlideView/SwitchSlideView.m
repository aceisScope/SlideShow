//
//  SwitchSlideView.m
//  SwitchSlideView
//
//  Created by B.H. Liu on 12-5-14.
//  Copyright (c) 2012年 Appublisher. All rights reserved.
//

#import "SwitchSlideView.h"

@interface SwitchSlideView()
@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,readwrite) NSInteger direction; //1- right 0- left
@end

@implementation SwitchSlideView
@synthesize scrollView=_scrollView;
@synthesize pageControl=_pageControl;
@synthesize titleLabel=_titleLabel;
@synthesize currentIndex=_currentIndex,totalPages=_totalPages;
@synthesize timer=_timer;
@synthesize direction=_direction;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scrollView = [[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 10)] autorelease];
        self.pageControl = [[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-10, self.frame.size.width, 10)] autorelease];
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 20)] autorelease];
        
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        
        self.pageControl.userInteractionEnabled = NO;
        
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        [self addSubview:self.titleLabel];
        
        UITapGestureRecognizer* tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)] autorelease];
        [self.scrollView addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)dealloc
{
    self.scrollView = nil;
    self.pageControl = nil;
    self.titleLabel = nil;
    self.timer = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setImagesWithArray:(NSArray *)array
{
    self.totalPages = array.count;
    self.pageControl.numberOfPages = self.totalPages;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.totalPages, self.scrollView.frame.size.height);
    self.currentIndex = 0;
    self.direction = 1;
    
    for (int i = 0; i<self.totalPages; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[array objectAtIndex:i]]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:imageView];
        [imageView release];
    }
    
    self.titleLabel.text = @"TEST FOR SLIDE";
    self.titleLabel.textAlignment = UITextAlignmentCenter;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(onTimerScroll) userInfo:nil repeats:YES];
}

- (void)onTimerScroll
{
    CGFloat offset_x = self.scrollView.contentOffset.x;
    if(self.direction == 1)
    {
        if (offset_x <= self.scrollView.contentSize.width - 2*self.scrollView.frame.size.width) 
        {
            offset_x += self.scrollView.frame.size.width;
            [self.scrollView setContentOffset:CGPointMake(offset_x, 0) animated:YES];
        }
        else if(self.currentIndex == self.totalPages -1)
        {
            self.direction = 0;
            offset_x -= self.scrollView.frame.size.width;
            [self.scrollView setContentOffset:CGPointMake(offset_x, 0) animated:YES];
        }  
    }
    else 
    {
        if (offset_x >= self.scrollView.frame.size.width) 
        {
            offset_x -= self.scrollView.frame.size.width;
            [self.scrollView setContentOffset:CGPointMake(offset_x, 0) animated:YES];
        }
        else if(self.currentIndex == 0)
        {
            self.direction = 1;
            offset_x += self.scrollView.frame.size.width;
            [self.scrollView setContentOffset:CGPointMake(offset_x, 0) animated:YES];
        } 
    }
    
}

#pragma mark-
#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView 
{
    int pageNum = round( scrollView.contentOffset.x / scrollView.frame.size.width);
    self.currentIndex = pageNum;
    self.pageControl.currentPage = pageNum;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(onTimerScroll) userInfo:nil repeats:YES];
}


- (void) tapped:(UITapGestureRecognizer*)tapRecognizer 
{
    NSLog(@"tap on %d",self.currentIndex);
}

@end
