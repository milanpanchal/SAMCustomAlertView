//
//  SAMAlertView.m
//  SAMCustomAlertView
//
//  Created by Milan Panchal on 7/8/15.
//  Copyright (c) 2015 Pantech. All rights reserved.
//

#import "SAMAlertView.h"
#import <QuartzCore/QuartzCore.h>


#define FONT_HELVETICA_NEUE_BOLD        @"HelveticaNeue-Bold"

#define COLOR_DEFAULT_BUTTON_BACKGROUND COLOR_RGBA(232,234,234,1)
#define COLOR_DEFAULT_BUTTON_TITLE      COLOR_RGBA(138,138,138,1)

#define BUTTON_CORNER_RADIUS            0.0f
#define BUTTON_HEIGHT                   40.0f


const static CGFloat kSAMAlertViewDefaultButtonSpacerHeight = 1;
const static CGFloat kSAMAlertViewMotionEffectExtent        = 10.0;

@interface SAMAlertView ()

@property (copy) void (^onButtonTouchUpInside)(SAMAlertView *alertView, int buttonIndex) ;
@property (nonatomic, retain) UIView *parentView;    // The parent view this 'dialog' is attached to
@property (nonatomic, retain) UIView *dialogView;    // Dialog's container view
@property (nonatomic, retain) UIView *containerView; // Container within the dialog (place your ui elements here)
@property (nonatomic, retain) UIView *buttonView;    // Buttons on the bottom of the dialog

@end


@implementation SAMAlertView

CGFloat buttonHeight = 0;
CGFloat buttonSpacerHeight = 0;

@synthesize onButtonTouchUpInside;
@synthesize delegate;
@synthesize useMotionEffects;

- (id)initWithParentView: (UIView *)parentView
{
    self = [super init];
    if (self) {
        
        if (parentView) {
            self.frame = parentView.frame;
            _parentView = parentView;
        } else {
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
        
        delegate            = self;
        useMotionEffects    = false;
        _buttonTitles        = @[@"Close"];
        _buttonColors        = @[COLOR_DEFAULT_BUTTON_BACKGROUND];
        _buttonTitleColors   = @[COLOR_DEFAULT_BUTTON_TITLE];
        self.autoCloseAlert = YES;
        //        _buttonImages = @[[UIImage imageNamed:@"close"]];
        
    }
    return self;
}

- (id)init {
    return [self initWithParentView:NULL];
}

// Create the dialog view, and animate opening the dialog
- (void)show {
    _dialogView = [self create_containerView];
    
    self.layer.shouldRasterize      = _dialogView.layer.shouldRasterize      = YES;
    self.layer.rasterizationScale   = _dialogView.layer.rasterizationScale   = [[UIScreen mainScreen] scale];
    
#if (defined(__IPHONE_7_0))
    if (useMotionEffects) {
        [self applyMotionEffects];
    }
#endif
    
    _dialogView.layer.opacity    = 0.5f;
    _dialogView.layer.transform  = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    self.backgroundColor        = [UIColor blackColor];
    
    [self addSubview:_dialogView];
    
    // Can be attached to a view or to the top most window
    // Attached to a view:
    if (_parentView != NULL) {
        [_parentView addSubview:self];
        
        // Attached to the top most window (make sure we are using the right orientation):
    } else {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        
        switch (interfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
                self.transform = CGAffineTransformMakeRotation(M_PI * 270.0 / 180.0);
                break;
                
            case UIInterfaceOrientationLandscapeRight:
                self.transform = CGAffineTransformMakeRotation(M_PI * 90.0 / 180.0);
                break;
                
            case UIInterfaceOrientationPortraitUpsideDown:
                self.transform = CGAffineTransformMakeRotation(M_PI * 180.0 / 180.0);
                break;
                
            default:
                break;
        }
        
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [[[[UIApplication sharedApplication] windows] lastObject] addSubview:self];
    }
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
                         _dialogView.layer.opacity = 1.0f;
                         _dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL
     ];
}

+ (SAMAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message {
    
    SAMAlertView* alertView = [[SAMAlertView alloc] init];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertView.bounds.size.width - 40, 100)];
    
    // Add some custom content to the alert view
    
    UILabel *titleLabel         = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, view.bounds.size.width - 40, 100)];
    titleLabel.numberOfLines    = 0;
    titleLabel.text             = title;
    titleLabel.font             = [UIFont fontWithName:FONT_HELVETICA_NEUE_BOLD size:18.0f];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    [titleLabel sizeToFit];
    
    CGRect frame        = titleLabel.frame;
    frame.size.width    =  view.bounds.size.width - 40;
    titleLabel.frame    = frame;
    [view addSubview:titleLabel];
    
    // Add some custom content to the alert view
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                                      titleLabel.frame.origin.y + titleLabel.frame.size.height + 10,
                                                                      view.bounds.size.width - 40,
                                                                      100)];
    
    messageLabel.numberOfLines  = 0;
    messageLabel.text           = [message stringByAppendingFormat:@"\n"];
    messageLabel.textColor      = COLOR_RGBA(84, 83, 83, 1);
    messageLabel.font           = [UIFont fontWithName:FONT_HELVETICA_NEUE_BOLD size:15.0f];
    messageLabel.textAlignment  = NSTextAlignmentCenter;
    [messageLabel sizeToFit];
    
    CGRect frame2       = messageLabel.frame;
    frame2.size.width   =  view.bounds.size.width - 40;
    messageLabel.frame  = frame2;
    [view addSubview:messageLabel];

    [view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect frame3       = view.frame;
    frame3.size.height  = titleLabel.bounds.size.height + messageLabel.bounds.size.height + 30;
    view.frame          = frame3;

    [alertView setContainerView:view];
    [alertView setUseMotionEffects:true];
    
    
    return alertView;
}

// Button has touched
- (void)alertViewDialogButtonTouchUpInside:(id)sender {

    if (delegate != NULL) {
        [delegate alertViewDialogButtonTouchUpInside:self clickedButtonAtIndex:[sender tag]];
    }
    
    if (onButtonTouchUpInside != NULL) {
        onButtonTouchUpInside(self, (int)[sender tag]);
    }
}

// Default button behaviour
- (void)alertViewDialogButtonTouchUpInside:(SAMAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (self.autoCloseAlert) {
        [self close];        
    }

}

// Dialog close animation then cleaning and removing the view from the parent
- (void)close {
    _dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    _dialogView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor blackColor];
                         _dialogView.layer.transform = CATransform3DMakeScale(0.6f, 0.6f, 1.0);
                         _dialogView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}

- (void)setSubView: (UIView *)subView {
    _containerView = subView;
}

// Creates the container view here: create the dialog, then add the custom content and buttons
- (UIView *)create_containerView {
    
    if ([_buttonTitles count] > 0) {
        buttonHeight       = BUTTON_HEIGHT;
        buttonSpacerHeight = kSAMAlertViewDefaultButtonSpacerHeight;
    } else {
        buttonHeight = 0;
        buttonSpacerHeight = 0;
    }
    
    if (_containerView == NULL) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    }
    
    CGFloat dialogWidth = _containerView.frame.size.width;
    CGFloat dialogHeight /*= _containerView.frame.size.height + (buttonHeight + buttonSpacerHeight) * ([_buttonTitles count])*/;
    
    
    if (_buttonTitles.count == 2) {
        dialogHeight = _containerView.frame.size.height + (buttonHeight + buttonSpacerHeight) * ([_buttonTitles count]-1);
    }else {
        dialogHeight = _containerView.frame.size.height + (buttonHeight + buttonSpacerHeight) * [_buttonTitles count];
    }
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        CGFloat tmp = screenWidth;
        screenWidth = screenHeight;
        screenHeight = tmp;
    }
    
    // For the black background
    [self setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    // This is the dialog's container; we attach the custom content and the buttons to this one
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenWidth - dialogWidth) / 2, (screenHeight - dialogHeight) / 2, dialogWidth, dialogHeight)];
    
    // First, we style the dialog to match the iOS7 UIAlertView >>>
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = dialogContainer.bounds;
    gradient.colors = @[(id)[COLOR_RGBA(218, 218, 218, 1) CGColor],
                        (id)[COLOR_RGBA(233, 233, 233, 1) CGColor],
                        (id)[COLOR_RGBA(218, 218, 218, 1) CGColor]];
    
    gradient.cornerRadius = BUTTON_CORNER_RADIUS;
    [dialogContainer.layer insertSublayer:gradient atIndex:0];
    
    dialogContainer.layer.cornerRadius  = BUTTON_CORNER_RADIUS;
    dialogContainer.layer.borderColor   = [COLOR_RGBA(198, 198, 198, 1) CGColor];
    dialogContainer.layer.borderWidth   = 1;
    dialogContainer.layer.shadowRadius  = BUTTON_CORNER_RADIUS + 5;
    dialogContainer.layer.shadowOpacity = 0.1f;
    dialogContainer.layer.shadowOffset  = CGSizeMake(0 - (BUTTON_CORNER_RADIUS+5)/2, 0 - (BUTTON_CORNER_RADIUS+5)/2);
    dialogContainer.layer.shadowColor   = [UIColor blackColor].CGColor;
    dialogContainer.layer.shadowPath    = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds
                                                                     cornerRadius:dialogContainer.layer.cornerRadius].CGPath;
    
    // Add the custom container if there is any
    [dialogContainer addSubview:_containerView];
    
    // Add the buttons too
    [self addButtonsToView:dialogContainer];
    
    return dialogContainer;
}

- (void)addButtonsToView:(UIView *)container {
    
    for (int i = 0; i < [_buttonTitles count]; i++) {
        
        UIButton *alertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (_buttonTitles.count == 2) {
            
            if (i == 0) {
                [alertButton setFrame:CGRectMake(0,
                                                 container.bounds.size.height -  (buttonHeight + buttonSpacerHeight),
                                                 _containerView.bounds.size.width/2,
                                                 buttonHeight)];
                
            } else {
                [alertButton setFrame:CGRectMake(_containerView.bounds.size.width/2,
                                                 container.bounds.size.height -  (buttonHeight + buttonSpacerHeight),
                                                 _containerView.bounds.size.width/2,
                                                 buttonHeight)];
                
            }
            
        }else {
            [alertButton setFrame:CGRectMake(0,
                                             container.bounds.size.height - ([_buttonTitles count] - i) * (buttonHeight + buttonSpacerHeight),
                                             _containerView.bounds.size.width,
                                             buttonHeight)];
            
        }
        
        
        // Set Button background colors
        UIColor *buttonBackgroundColor = COLOR_DEFAULT_BUTTON_BACKGROUND;

        if([_buttonColors count] > i && _buttonColors[i]) {
            buttonBackgroundColor = _buttonColors[i];
        }
        [alertButton setBackgroundColor:buttonBackgroundColor];

        
        // Set Button title colors

        UIColor *titleColor = COLOR_DEFAULT_BUTTON_TITLE;
        if ([_buttonTitleColors count] > i && _buttonTitleColors[i]) {
            titleColor = _buttonTitleColors[i];
        }
        
        [alertButton setTitleColor:titleColor forState:UIControlStateNormal];
        [alertButton setTitleColor:titleColor forState:UIControlStateHighlighted];
        [alertButton setTintColor:titleColor];

        // Set the Image for the button
        if ([_buttonImages count] > i && _buttonImages[i]) {
            [alertButton setImage:_buttonImages[i] forState:UIControlStateNormal];
            [alertButton setImage:_buttonImages[i] forState:UIControlStateHighlighted];
            [alertButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
            
        }else {
            [alertButton setImage:nil forState:UIControlStateNormal];
        }
        
        
        [alertButton addTarget:self action:@selector(alertViewDialogButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [alertButton setTag:i];
        [alertButton setTitle:_buttonTitles[i] forState:UIControlStateNormal];
        [alertButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [alertButton.layer setCornerRadius:BUTTON_CORNER_RADIUS];
        [container addSubview:alertButton];
    }
    
}

#if (defined(__IPHONE_7_0))
// Add motion effects
- (void)applyMotionEffects {
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        return;
    }
    
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalEffect.minimumRelativeValue = @(-kSAMAlertViewMotionEffectExtent);
    horizontalEffect.maximumRelativeValue = @( kSAMAlertViewMotionEffectExtent);
    
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                  type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalEffect.minimumRelativeValue = @(-kSAMAlertViewMotionEffectExtent);
    verticalEffect.maximumRelativeValue = @( kSAMAlertViewMotionEffectExtent);
    
    UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
    motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
    
    [_dialogView addMotionEffect:motionEffectGroup];
}
#endif


@end
