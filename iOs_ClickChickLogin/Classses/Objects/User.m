//
//  User.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize user_id;
@synthesize username;
@synthesize password;
@synthesize email;

- (id) initWithParams:(NSInteger)userId_ username:(NSString*)username_
             password:(NSString*)password_ email:(NSString*)email_
{
    if (self = [super init]) {
        user_id = userId_;
        username = username_;
        password = password_;
        email = email_;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        [self setUser_id:[aDecoder decodeIntegerForKey:@"user_id"]];
        [self setUsername:[aDecoder decodeObjectForKey:@"username"]];
        [self setEmail:[aDecoder decodeObjectForKey:@"email"]];
        [self setPassword:[aDecoder decodeObjectForKey:@"password"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:user_id forKey:@"user_id"];
    [aCoder encodeObject:username forKey:@"username"];
    [aCoder encodeObject:email forKey:@"email"];
    [aCoder encodeObject:password forKey:@"password"];

}

@end
