//
//  ViewController.m
//  SAMCustomAlertView
//
//  Created by Milan Panchal on 7/8/15.
//  Copyright (c) 2015 Pantech. All rights reserved.
//

#import "ViewController.h"
#import "SAMAlertView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIButton *actionButton = [UIButton new];
    [actionButton setTitle:@"Show Custom Alert" forState:UIControlStateNormal];
    [actionButton setBackgroundColor:COLOR_RGBA(0, 0, 255, 0.7)];
    [actionButton addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [actionButton.layer setCornerRadius:8.0f];
    [self.view addSubview:actionButton];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:actionButton
                                      attribute:NSLayoutAttributeCenterX
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.view
                                      attribute:NSLayoutAttributeCenterX
                                     multiplier:1
                                       constant:0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:actionButton
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self.view
                                      attribute:NSLayoutAttributeCenterY
                                     multiplier:1
                                       constant:0];
    
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:actionButton
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1
                                                                constant:20];

    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:actionButton
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1
                                                                constant:-20];

    
    [self.view addConstraint:leading];
    [self.view addConstraint:trailing];
    [self.view addConstraint:centerX];
    [self.view addConstraint:centerY];

    
    actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.translatesAutoresizingMaskIntoConstraints = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)showAlert {
    
    SAMAlertView *alertView = [SAMAlertView alertWithTitle:@"Custom Alert Title" message:@"Your custom message will appear here!"];
    [alertView setButtonTitles:@[@"CANCEL",@"ADD",@"DELETE"]];
    [alertView setButtonColors:@[COLOR_RGBA(232, 234, 234, 1), COLOR_RGBA(65, 150, 241, 1),COLOR_RGBA(60, 15, 248, 1)]];
    [alertView setButtonTitleColors:@[COLOR_RGBA(145, 145, 145, 1), COLOR_RGBA(255, 255, 255, 1),COLOR_RGBA(255, 255, 255, 1)]];
    [alertView setButtonImages:@[IMAGE_CROSS_ICON,IMAGE_ADD_ICON,IMAGE_DELETE_ICON]];
    [alertView setCustomButtonAlignment:CustomButtonAlignmentVertical];
    [alertView setOnButtonTouchUpInside:^(SAMAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %ld.", buttonIndex, (long)[alertView tag]);
        
    }];
    [alertView show];
    
}

@end
