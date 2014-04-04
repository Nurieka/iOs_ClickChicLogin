//
//  ProductListViewController.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "ProductListViewController.h"
#import "CustomProductCell.h"
#import "ProductAddViewController.h"
#import "ProductDetailViewController.h"

@interface ProductListViewController ()

@end

@implementation ProductListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       arrayData = [[SQLManager sharedInstance] findAllProducts];
        arrayImgs = [[NSMutableArray alloc] initWithCapacity:0];
        [arrayImgs addObject:[UIImage imageNamed:@"prod_1.png"]];
        [arrayImgs addObject:[UIImage imageNamed:@"prod_2.png"]];
        [arrayImgs addObject:[UIImage imageNamed:@"prod_3.png"]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableProducts setDelegate:self];
    [self.tableProducts setDataSource:self];
    
    [self setTitle:@"ClickChic"];
    
    // Add items to the TopBar Navigation
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProduct)];

    self.navigationItem.rightBarButtonItem = addButtonItem;
    
    NSLog(@"%d", [[UserDefaults sharedInstance] retrieveUserDefaults]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    arrayData = [[SQLManager sharedInstance] findAllProducts];
    [self.tableProducts reloadData];
}

# pragma mark - UITableView DataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CellIdentifier";
    
    CustomProductCell *cell = (CustomProductCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomProductCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell.labelDescription setText:[[arrayData objectAtIndex:indexPath.row] description]];
    [cell.imageProduct setImage:[arrayImgs objectAtIndex:arc4random_uniform(3)]];
    
    [cell.labelAuthor setText:@"Emma Emmerson"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayData count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 129;
}

#pragma mark - UITableView Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Product *product = [arrayData objectAtIndex:indexPath.row];
    
    ProductDetailViewController *productDetailViewController = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    [productDetailViewController setProduct:product];
    
    [self.navigationController pushViewController:productDetailViewController animated:YES];
    
    
}

# pragma mark - ProductAddViewControllerDelegate Methods

- (void)insertProduct:(Product*)product {
    
    [[SQLManager sharedInstance] addProduct:product];
    arrayData = [[SQLManager sharedInstance] findAllProducts];
    [self.tableProducts reloadData];
}

# pragma mark - IBAction Methods

- (void) addProduct {
    ProductAddViewController *productAddViewController = [[ProductAddViewController alloc] initWithNibName:@"ProductAddViewController" bundle:nil];
    
    [productAddViewController setDelegate:self];
    [self.navigationController pushViewController:productAddViewController animated:YES];
}


@end
