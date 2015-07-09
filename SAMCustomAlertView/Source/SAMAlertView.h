//
//  SAMAlertView.h
//  SAMCustomAlertView
//
//  Created by Milan Panchal on 7/8/15.
//  Copyright (c) 2015 Pantech. All rights reserved.
//

#import <UIKit/UIKit.h>
#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


/**
 * Set of default images
 */
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

/**
 * An array to set the button background colors that appears on custom alert.
 * If you will not set the property then default color RGBA(232,234,234,1)
 * will be applied as button background
 *
 */
@property (nonatomic, retain) NSArray *buttonColors;

/**
 * An array to set the button text colors that appears on custom alert.
 * If you will not set the property then default color RGBA(138,138,138,1)
 * will be applied as button background
 *
 */
@property (nonatomic, retain) NSArray *buttonTitleColors;

/**
 * An array to set to button titles that appears on custom alert.
 * Based on the array size button will be generated on custom alert
 *
 */
@property (nonatomic, retain) NSArray *buttonTitles;

/**
 * An array to set to button Image that appears on left side of the custom alert buttons.
 * You can also use default images provided along with the class that was defined as constants.
 *
 */
@property (nonatomic, retain) NSArray *buttonImages;

@property (nonatomic, assign) BOOL useMotionEffects;

/**
 * To close the alertview after any if the button selected on custom alert.
 * Default value is YES. If you don't want to close the custom alertview 
 * then set 
 * @code
 *  autoCloseAlert = NO
 * @endcode
 */
@property (nonatomic, assign, getter=willAutoCloseAlert) BOOL autoCloseAlert;

/**
 * Set the Button alignment on custom alert.
 * Default is Horizontal. You can set vertical alignmet by overriding the propery
 *
 * @code customButtonAlignment = CustomButtonAlignmentVertical @endcode
 *
 * Note: If buttons are more than 3 then its recommnetd to use vertical alignment
 * as its not visible on screen properly.
 */
@property (nonatomic, assign) CustomButtonAlignment customButtonAlignment ;

- (id)init;
- (id)initWithParentView: (UIView *)parentView;

- (void)show;
- (void)close;

- (void)alertViewDialogButtonTouchUpInside:(id)sender ;
- (void)setOnButtonTouchUpInside:(void (^)(SAMAlertView *alertView, int buttonIndex))onButtonTouchUpInside ;

+ (SAMAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message ;

@end
