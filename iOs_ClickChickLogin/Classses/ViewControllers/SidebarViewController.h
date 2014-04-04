//
//  SidebarViewController.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *arrayData;
    NSMutableArray *arrayIcons;
}

@property (weak, nonatomic) IBOutlet UITableView *tableSidebar;


@end
