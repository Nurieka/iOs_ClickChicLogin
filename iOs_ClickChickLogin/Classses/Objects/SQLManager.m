//
//  SQLManager.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "SQLManager.h"

@implementation SQLManager

@synthesize dbPath;
@synthesize database;

# pragma mark - Singleton

static SQLManager *sharedCLDelegate = nil;

+ (SQLManager *)sharedInstance
{
    @synchronized(self)
	{
        if (sharedCLDelegate == nil)
		{
            sharedCLDelegate = [[SQLManager alloc] initSQLiteManager];
        }
    }
    return sharedCLDelegate;
}

# pragma mark - Initializate Methods

- (id)initSQLiteManager
{
    if(self = [super init])
    {
        dbPath = nil;
        database = nil;
        [self copyDatabaseIfNeeded];
        sqlQueue = [[NSOperationQueue alloc] init];
        [sqlQueue setMaxConcurrentOperationCount:1];
    }
    return self;
}

- (void)copyDatabaseIfNeeded
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    // Database URL Path
    dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	
	if(!success) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:SQL_DATABASE_NAME];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		if (!success)
            NSLog(@"Error: %@",[error localizedDescription]);
	}
}

- (NSString *)getDBPath
{
	// Get Database URL Path
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:SQL_DATABASE_NAME];
}

- (void)finalizeStatements
{
	if(database) sqlite3_close(database);
}

#pragma mark - DB Products Methods

- (NSMutableArray *) findAllProducts
{
    
    @synchronized(self)
    {
        
        NSMutableArray *arrayProducts = [[NSMutableArray alloc] initWithCapacity:0];
        
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            NSString *sqlString= [NSString stringWithFormat:@"select product_id, user_id, title, desc, price from Products"];
            
            sqlite3_stmt *selectstmt;
            if(sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &selectstmt, NULL) == SQLITE_OK)
            {
                while(sqlite3_step(selectstmt) == SQLITE_ROW)
                {
                    NSInteger countElement=0;
                    
                    Product *product = [[Product alloc]init];
                    
                    product.product_id = sqlite3_column_int(selectstmt, countElement);
                    countElement++;
                    product.user_id = sqlite3_column_int(selectstmt, countElement);
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        product.title =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];
                    
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        product.description =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];
                    
                    countElement++;
                    product.price = [NSNumber numberWithFloat:sqlite3_column_double(selectstmt, countElement)];
                    
                    [arrayProducts addObject:product];
                }
                sqlite3_finalize(selectstmt);
            }
        }
        else
            sqlite3_close(database);
        
        return arrayProducts;
    }
}


- (BOOL) addProduct:(Product *)product
{
    
    @synchronized(self)
    {
        
        // Create insert statement
        NSString *insertStatement =@"insert into Products (user_id, title, desc, price) VALUES (?,?,?,?)";
        
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            sqlite3_exec(database, "BEGIN", 0, 0, 0);
            sqlite3_stmt *insertstmt;
            
            NSInteger countElement=1;
            
            if (sqlite3_prepare(database, [insertStatement UTF8String], -1, &insertstmt, NULL) == SQLITE_OK)
            {
                SQLITE_API int sqlite3_bind_int(sqlite3_stmt*, int, int);
                
                sqlite3_bind_int(insertstmt, countElement, product.user_id);
                countElement++;
                sqlite3_bind_text(insertstmt, countElement, [product.title UTF8String], -1, SQLITE_TRANSIENT);
                countElement++;
                sqlite3_bind_text(insertstmt, countElement, [product.description UTF8String], -1, SQLITE_TRANSIENT);
                countElement++;
                sqlite3_bind_double(insertstmt, countElement, [product.price floatValue]);
                
                sqlite3_step(insertstmt);
                sqlite3_reset(insertstmt);
            }
            else
            {
                NSLog(@"Error inserting in Database");
                NSLog(@"%s",__PRETTY_FUNCTION__);
                return NO;
            }
            
            sqlite3_exec(database, "COMMIT", 0, 0, 0);
        }
        sqlite3_close(database);
        return YES;
    }
}

- (BOOL) deleteProduct:(NSInteger)idProduct
{
    @synchronized(self)
    {
        char *error;
        
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            NSString *sqlString = [NSString stringWithFormat:@"delete from Products where product_id = '%d'",idProduct];
            
            sqlite3_stmt *selectstmt;
            
            sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &selectstmt, NULL);
            if (sqlite3_step(selectstmt) == SQLITE_DONE)
            {
                NSLog(@"Product removed successfully");
                
            }
            else
            {
                NSLog(@"Error: %s", error);
                return NO;
                
            }
            sqlite3_finalize(selectstmt);
            
        }
        else
            sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
        
        return YES;
    }
}

- (void) updateProduct:(Product*)product
{
    @synchronized(self)
    {
        
        //Actualizamos un vehiculo por su idVehiculo
        NSString *insertStatement = [NSString stringWithFormat:@"update Products SET user_id = \"%d\", title = \"%@\", desc = \"%@\", price = \"%f\" where product_id = '%d'", product.user_id, product.title, product.description, [product.price floatValue], product.product_id];
        
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            char *error;
            if ( sqlite3_exec(database, [insertStatement UTF8String], NULL, NULL, &error) == SQLITE_OK)
            {
                
                NSLog(@"Product updated successfully");
            }
            else
            {
#if DEBUG
                NSLog(@"Error: %s", error);
#endif
            }
        }
        else
            sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
        
    }
    
}

#pragma mark - DB Users Methods

- (NSMutableArray *) findUserByUsername:(NSString*)username
{
    @synchronized(self)
    {
        
        NSMutableArray *arrayData = [[NSMutableArray alloc] initWithCapacity:0];
        
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            NSString *sqlString= [NSString stringWithFormat:@"select user_id, username, email, password from Users where username = '%@'", username];
            
            sqlite3_stmt *selectstmt;
            if(sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &selectstmt, NULL) == SQLITE_OK)
            {
                while(sqlite3_step(selectstmt) == SQLITE_ROW)
                {
                    NSInteger countElement=0;
                    
                    User *user = [[User alloc]init];
                    
                    user.user_id = sqlite3_column_int(selectstmt, countElement);
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        user.username =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];
                    
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        user.email =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];
                    
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        user.password =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];
                    
                    
                    [arrayData addObject:user];
                }
                sqlite3_finalize(selectstmt);
            }
        }
        else
            sqlite3_close(database);
        
        return arrayData;
    }
}

- (NSMutableArray *) findUserById:(NSInteger)userId
{
    @synchronized(self)
    {
        
        NSMutableArray *arrayData = [[NSMutableArray alloc] initWithCapacity:0];
        
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            NSString *sqlString= [NSString stringWithFormat:@"select user_id, username, email, password from Users where user_id = '%d'", userId];
            
            sqlite3_stmt *selectstmt;
            if(sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &selectstmt, NULL) == SQLITE_OK)
            {
                while(sqlite3_step(selectstmt) == SQLITE_ROW)
                {
                    NSInteger countElement=0;
                    
                    User *user = [[User alloc]init];
                    
                    user.user_id = sqlite3_column_int(selectstmt, countElement);
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        user.username =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];
                    
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        user.email =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];
                    
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        user.password =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];
                    
                    
                    [arrayData addObject:user];
                }
                sqlite3_finalize(selectstmt);
            }
        }
        else
            sqlite3_close(database);
        
        return arrayData;
    }
}

- (NSMutableArray *) findAllUsers
{
    
    @synchronized(self)
    {
        
        NSMutableArray *arrayData = [[NSMutableArray alloc] initWithCapacity:0];
        
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            NSString *sqlString= [NSString stringWithFormat:@"select user_id, username, email, password from Users"];
            
            sqlite3_stmt *selectstmt;
            if(sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &selectstmt, NULL) == SQLITE_OK)
            {
                while(sqlite3_step(selectstmt) == SQLITE_ROW)
                {
                    NSInteger countElement=0;
                    
                    User *user = [[User alloc]init];
                    
                    user.user_id = sqlite3_column_int(selectstmt, countElement);
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        user.username =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];
                    
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        user.email =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];
                    
                    countElement++;
                    if((char *)sqlite3_column_text(selectstmt, countElement)!=nil)
                        user.password =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, countElement)];

                    
                    [arrayData addObject:user];
                }
                sqlite3_finalize(selectstmt);
            }
        }
        else
            sqlite3_close(database);
        
        return arrayData;
    }
}

- (BOOL) addUser:(User *)user
{
    
    @synchronized(self)
    {
        
        // Create insert statement
        NSString *insertStatement =@"insert into Users (username, email, password) VALUES (?,?,?)";
        
        if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
        {
            sqlite3_exec(database, "BEGIN", 0, 0, 0);
            sqlite3_stmt *insertstmt;
            
            NSInteger countElement=1;
            
            if (sqlite3_prepare(database, [insertStatement UTF8String], -1, &insertstmt, NULL) == SQLITE_OK)
            {
                SQLITE_API int sqlite3_bind_int(sqlite3_stmt*, int, int);
                
                sqlite3_bind_text(insertstmt, countElement, [user.username UTF8String], -1, SQLITE_TRANSIENT);
                countElement++;
                sqlite3_bind_text(insertstmt, countElement, [user.email UTF8String], -1, SQLITE_TRANSIENT);
                countElement++;
                sqlite3_bind_text(insertstmt, countElement, [user.password UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_step(insertstmt);
                sqlite3_reset(insertstmt);
                
                NSLog(@"User added successfully to Database");
            }
            else
            {
                NSLog(@"Error inserting in Database");
                NSLog(@"%s",__PRETTY_FUNCTION__);
                return NO;
            }
            
            sqlite3_exec(database, "COMMIT", 0, 0, 0);
        }
        sqlite3_close(database);
        return YES;
    }
}




@end
