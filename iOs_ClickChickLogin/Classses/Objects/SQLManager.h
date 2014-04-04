//
//  SQLManager.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Product.h"
#import "User.h"

#define SQL_DATABASE_NAME @"dbClickChic.sqlite"

@interface SQLManager : NSObject
{
    NSOperationQueue *sqlQueue;
}

@property (nonatomic, retain) NSString *dbPath;
@property (nonatomic, assign) sqlite3 *database;

+ (SQLManager *)sharedInstance;

- (void)copyDatabaseIfNeeded;
- (NSString *)getDBPath;
- (void)finalizeStatements;

# pragma mark - DB Products Methods

- (BOOL) addProduct:(Product *)product;
- (BOOL) deleteProduct:(NSInteger)idProduct;
- (void) updateProduct:(Product*)product;
- (NSMutableArray *) findAllProducts;

# pragma mark - DB Users Methods

- (NSMutableArray *) findAllUsers;
- (NSMutableArray *) findUserByUsername:(NSString*)username;
- (NSMutableArray *) findUserById:(NSInteger)userId;
- (BOOL) addUser:(User *)user;



@end
