//
//  UICustomize.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UICustomize : NSObject

+ (id) sharedInstance;
- (void) setLoginStyleButton:(UIButton*)button color:(UIColor*)color;
- (void) setLoginStyleTextfield:(UITextField*)textfield;
- (void) setViewAsShadow:(UIView *)view;
@end
