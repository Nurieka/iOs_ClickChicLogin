//
//  User.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

- (id) initWithParams:(NSInteger)userId_ username:(NSString*)username_
             password:(NSString*)password_ email:(NSString*)email_;

@end
