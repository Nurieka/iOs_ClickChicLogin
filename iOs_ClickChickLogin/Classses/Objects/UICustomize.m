//
//  UICustomize.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "UICustomize.h"
#import <QuartzCore/QuartzCore.h>

@implementation UICustomize

+ (id) sharedInstance {
    static UICustomize *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void) setLoginStyleButton:(UIButton*)button color:(UIColor*)color {
    [button.layer setBackgroundColor:color.CGColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button.layer setCornerRadius:4];
    [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, 38)];
}

- (void) setLoginStyleTextfield:(UITextField*)textfield {
    [textfield setFrame:CGRectMake(textfield.frame.origin.x, textfield.frame.origin.y, textfield.frame.size.width, 38)];    
}

- (void) setViewAsShadow:(UIView *)view {
    [view.layer setBackgroundColor:[UIColor blackColor].CGColor];
    [view.layer setOpacity:0.5];
    [view.layer setCornerRadius:4];
}

- (void) setBottomButtom:(UIButton*)button color:(UIColor*)color {
    [button.layer setBackgroundColor:color.CGColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, 45)];
}

@end
