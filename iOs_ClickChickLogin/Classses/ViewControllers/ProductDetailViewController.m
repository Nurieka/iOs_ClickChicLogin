//
//  ProductDetailViewController.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

@synthesize product;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *deleteButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(pushDeleteProduct:)];
    
    UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(pushEditProduct:)];
    
    [self.navigationItem setRightBarButtonItems:[[NSArray alloc]initWithObjects:deleteButtonItem, editButtonItem, nil]];
    
    [self setupAppearence];
    
    // Set Product Values into UI elements
    [self setElementsWithProductValues:product];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Private Methods

- (void) setupAppearence {
    [[UICustomize sharedInstance] setBottomButtom:self.buttonBuy color:[UIColors kCyanColor]];
}

- (void) setElementsWithProductValues:(Product *)p {
    // Set Product Values into UI elements
    [self.labelTitle setText:p.title];
    [self.labelPrice setText:[NSString stringWithFormat:@"%f",[p.price floatValue]]];
    [self.labelDescription setText:p.description];
    
}

# pragma mark - IBAction Methods

- (IBAction)pushDeleteProduct:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Product" message:@"You are deleting a product. Are you sure you want delete it?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    [alert show];
}

- (IBAction)pushEditProduct:(id)sender
{
    ProductAddViewController *productAddViewController = [[ProductAddViewController alloc] initWithNibName:@"ProductAddViewController" bundle:nil];
    [productAddViewController setEditingProduct:product];
    [productAddViewController setDelegate:self];
    [self.navigationController pushViewController:productAddViewController animated:YES];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Delete"]) {
        [[SQLManager sharedInstance] deleteProduct:product.product_id];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

# pragma mark - ProductAddViewController Delegate Methods
- (void)insertProduct:(Product*)produc {
    self.product = produc;
    [self setElementsWithProductValues:product];

    // Save updated product in database
    [[SQLManager sharedInstance] updateProduct:produc];
}



@end
