//
//  FormatError.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//
//  Errors support for types: notnullstring and email

#import <Foundation/Foundation.h>

@interface FormatError : NSObject

+ (id) sharedInstance;

- (BOOL) isValidEmail:(NSString *)emailString Strict:(BOOL)strictFilter;
- (BOOL) isValidNotNullString:(NSString *)notnullString;

@end
