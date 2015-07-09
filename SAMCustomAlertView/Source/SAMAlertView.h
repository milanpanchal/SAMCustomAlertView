//
//  SAMAlertView.h
//  SAMCustomAlertView
//
//  Created by Milan Panchal on 7/8/15.
//  Copyright (c) 2015 Pantech. All rights reserved.
//

#import <UIKit/UIKit.h>
#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define IMAGE_ADD_ICON      [UIImage imageNamed:@"add_icon"]
#define IMAGE_EDIT_ICON     [UIImage imageNamed:@"edit_icon"]
#define IMAGE_DELETE_ICON   [UIImage imageNamed:@"delete_icon"]
#define IMAGE_CROSS_ICON    [UIImage imageNamed:@"cross_icon"]
#define IMAGE_CALL_ICON     [UIImage imageNamed:@"call_icon"]
#define IMAGE_TICK_MARK_ICON [UIImage imageNamed:@"tickmark_icon"]
#define IMAGE_NOTIFY_ICON   [UIImage imageNamed:@"notify_icon"]
#define IMAGE_SAVE_ICON     [UIImage imageNamed:@"save_icon"]

typedef NS_ENUM(short, CustomButtonAlignment) {
    CustomButtonAlignmentHorizontal,
    CustomButtonAlignmentVertical,
};

@protocol SAMAlertViewDelegate

- (void)alertViewDialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface SAMAlertView : UIView<SAMAlertViewDelegate>


@property (nonatomic, assign) id<SAMAlertViewDelegate> delegate;
@property (nonatomic, retain) NSArray *buttonColors;
@property (nonatomic, retain) NSArray *buttonTitleColors;
@property (nonatomic, retain) NSArray *buttonTitles;
@property (nonatomic, retain) NSArray *buttonImages;
@property (nonatomic, assign) BOOL useMotionEffects;
@property (nonatomic, assign, getter=willAutoCloseAlert) BOOL autoCloseAlert;
@property (nonatomic, assign) CustomButtonAlignment customButtonAlignment ;

- (id)init;
- (id)initWithParentView: (UIView *)parentView;

- (void)show;
- (void)close;

- (void)alertViewDialogButtonTouchUpInside:(id)sender ;
- (void)setOnButtonTouchUpInside:(void (^)(SAMAlertView *alertView, int buttonIndex))onButtonTouchUpInside ;

+ (SAMAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message ;

@end
