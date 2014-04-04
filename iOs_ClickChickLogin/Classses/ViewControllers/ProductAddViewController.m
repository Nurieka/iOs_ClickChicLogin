//
//  ProductAddViewController.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "ProductAddViewController.h"

@interface ProductAddViewController ()

@end

@implementation ProductAddViewController

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

    // Set delegates
    [self.textfieldPrice setDelegate:self];
    [self.textfieldTitle setDelegate:self];
    [self.textfieldDescription setDelegate:self];
    
    if (self.editingProduct) {
        [self setUIElementsWithProductValues:self.editingProduct];
    }
    
    UIBarButtonItem *addProduct = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushAddButton:)];
    self.navigationItem.rightBarButtonItem = addProduct;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Methods

- (IBAction)pushAddButton:(id)sender {
    
    // Check if delegate is instantiated and send info
    if (self.delegate && [self.delegate respondsToSelector:@selector(insertProduct:)])
    {
        Product *product = [self setProductWithUIElements];
        [self.delegate insertProduct:product];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

# pragma mark - Private Methods

- (Product *) setProductWithUIElements {
    Product *product = [[Product alloc] init];
    [product setUser_id:[[UserDefaults sharedInstance] retrieveUserDefaults]];
    [product setPrice:[NSNumber numberWithFloat:[self.textfieldPrice.text floatValue]]];
    [product setDescription:self.textfieldDescription.text];
    [product setTitle:self.textfieldTitle.text];

    return product;
}

- (void) setUIElementsWithProductValues:(Product*)prod {
    [self.textfieldTitle setText:prod.title];
    [self.textfieldPrice setText:[NSString stringWithFormat:@"%f",[prod.price floatValue]]];
    [self.textfieldDescription setText:prod.description];
}

@end
