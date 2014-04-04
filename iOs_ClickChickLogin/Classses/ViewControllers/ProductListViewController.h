//
//  ProductListViewController.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductAddViewController.h"

@interface ProductListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ProductAddViewControllerDelegate>
{
    NSMutableArray *arrayData;
    NSMutableArray *arrayImgs;
}

@property (weak, nonatomic) IBOutlet UITableView *tableProducts;


@end
