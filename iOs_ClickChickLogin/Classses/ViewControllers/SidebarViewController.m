//
//  SidebarViewController.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "SidebarViewController.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

#import "ProductListViewController.h"
#import "WishListViewController.h"
#import "SignInViewController.h"

#import "CustomSidebarCell.h"

@interface SidebarViewController ()

@end

@implementation SidebarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        arrayData = [[NSMutableArray alloc] initWithCapacity:0];
        [arrayData addObject:@"Products"];
        [arrayData addObject:@"Whishes"];
        [arrayData addObject:@"Find Shops"];
        [arrayData addObject:@"Quit"];
        
        arrayIcons = [[NSMutableArray alloc] initWithCapacity:0];
        [arrayIcons addObject:@"sid_prod.png"];
        [arrayIcons addObject:@"sid_shop.png"];
        [arrayIcons addObject:@"sid_trend.png"];
        [arrayIcons addObject:@"sid_quit.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableSidebar setDelegate:self];
    [self.tableSidebar setDataSource:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView DataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = @"CellIdentifier";
    
    CustomSidebarCell *cell = (CustomSidebarCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomSidebarCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell.labelTitle setText:[arrayData objectAtIndex:indexPath.row]];
    [cell.imageMenu setImage:[UIImage imageNamed:[arrayIcons objectAtIndex:indexPath.row]]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayData count];
}

#pragma mark UITAbleView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UINavigationController *navigation;
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:
        {
            //[self.sidePanelController toggleLeftPanel:self.sidePanelController.leftPanel];
            ProductListViewController *productListViewController = [[ProductListViewController alloc] init];
            navigation = [[UINavigationController alloc] initWithRootViewController:productListViewController];
            self.sidePanelController.centerPanel = navigation;
            break;
        }
        case 1:
        {
            WishListViewController *wishListViewController = [[WishListViewController alloc] init];
            navigation = [[UINavigationController alloc] initWithRootViewController:wishListViewController];
            self.sidePanelController.centerPanel = navigation;
            break;
        }
        case 2:
        {

            break;
        }
    }
}

@end
