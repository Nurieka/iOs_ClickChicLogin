//
//  UserDefaults.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

+ (id) sharedInstance;

- (void) saveUserDefaults:(User *)user;
- (NSInteger) retrieveUserDefaults;
@end
