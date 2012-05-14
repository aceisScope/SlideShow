//
//  ViewController.m
//  SwitchSlideView
//
//  Created by B.H. Liu on 12-5-14.
//  Copyright (c) 2012年 Appublisher. All rights reserved.
//

#import "ViewController.h"
#import "SwitchSlideView.h"

@interface ViewController ()
@property (nonatomic,retain) SwitchSlideView *switchSlide;
@end

@implementation ViewController
@synthesize switchSlide=_switchSlide;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *images= [NSArray arrayWithObjects:@"01.jpg",@"02.png",@"03.jpg" ,nil];
    
    self.switchSlide = [[SwitchSlideView alloc]initWithFrame:CGRectMake(0, 10, 320, 240)];
    [self.view addSubview:self.switchSlide];
    [self.switchSlide setImagesWithArray:images];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
