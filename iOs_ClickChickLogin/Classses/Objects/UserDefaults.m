//
//  UserDefaults.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

+ (id) sharedInstance {
    static UserDefaults *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSInteger) retrieveUserDefaults {
    
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedDictionary = [currentDefaults objectForKey:@"current_user"];
    
    if (dataRepresentingSavedDictionary != nil)
    {
        User *user = [[User alloc] init];
        user = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedDictionary];
        return user.user_id;
    }
    return -1;
}

- (void) saveUserDefaults:(User *)user {
    // Store User in stardarUserDefaults
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults)
    {
        [standardUserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:user] forKey:@"current_user"];
        [standardUserDefaults synchronize];
    }
}

@end
