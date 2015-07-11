# SAMCustomAlertView
Show Custom AlertView on UIVIew/UIWindow


##Installation 

### Cocoapods

    pod 'SAMAlertView', '~> 1.0.0'

### From Source

Pretty simple. Just download or clone in Desktop. Drag and drop Source and Resources folder in your project. After that, add following statement wherever you wish to add.

	#import <SAMAlertView.h> 	/*If you added via cocoapods*/
	#import "SAMAlertView.h" 	/*If you added manually*/

##How to use?

    SAMAlertView *alertView = [SAMAlertView alertWithTitle:@"Your Custom Alert Title" message:@"Your custom message will appear here!"];
    [alertView setButtonTitles:@[@"CANCEL",@"ADD"]];
    [alertView setButtonColors:@[COLOR_RGBA(232, 234, 234, 1), COLOR_RGBA(65, 150, 241, 1)]];
    [alertView setButtonTitleColors:@[COLOR_RGBA(145, 145, 145, 1), COLOR_RGBA(255, 255, 255, 1)]];
    [alertView setButtonImages:@[IMAGE_CROSS_ICON,IMAGE_ADD_ICON]];
    [alertView setCustomButtonAlignment:CustomButtonAlignmentHorizontal];
    //[alertView setCustomButtonAlignment:CustomButtonAlignmentVertical];

    [alertView setOnButtonTouchUpInside:^(SAMAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %ld.", buttonIndex, (long)[alertView tag]);
        
    }];
    [alertView show];

##Screenshot

**Horizontal Buttons**

![image](https://raw.github.com/milanpanchal/SAMCustomAlertView/master/Screenshots/horizontal_alert.png)

**Vertical Buttons**

![image](https://raw.github.com/milanpanchal/SAMCustomAlertView/master/Screenshots/vertical_alert.png)


##Next Step

Please feel free to contribute the project as much as you can. Planning to add more methods.


##Contact


Follow me on 

1. **Twitter** ([@milan_panchal24](https://twitter.com/milan_panchal24))

2. **Github** ([/milanpanchal](https://github.com/milanpanchal/))

3. **Blog** ([https://techfuzionwithsam.wordpress.com/](https://techfuzionwithsam.wordpress.com/))



##License

SAMCustomAlertView is available under the MIT license. See the [LICENSE](https://github.com/milanpanchal/SAMCustomAlertView/blob/master/LICENSE) file for more info.



