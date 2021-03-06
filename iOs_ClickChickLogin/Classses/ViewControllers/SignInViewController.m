//
//  SignInViewController.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "SignInViewController.h"

#import "JASidePanelController.h"
#import "SidebarViewController.h"
#import "ProductListViewController.h"
#import "SignUpViewController.h"
#import "User.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

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
    [self setupAppearence];
    
    [self.textfieldUsername setDelegate:self];
    [self.textfieldPassword setDelegate:self];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

# pragma mark - UITextfield Delegate Methods

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Private Methods

-(void) setupAppearence {
    [[UICustomize sharedInstance] setLoginStyleButton:self.buttonConnect color:[UIColors kCyanColor]];
    [[UICustomize sharedInstance] setLoginStyleButton:self.buttonFacebook color:[UIColors kBlueColor]];
    [[UICustomize sharedInstance] setLoginStyleTextfield:self.textfieldUsername];
    [[UICustomize sharedInstance] setLoginStyleTextfield:self.textfieldPassword];
    
    [[UICustomize sharedInstance] setViewAsShadow:self.viewShadowConnect];
    [[UICustomize sharedInstance] setViewAsShadow:self.viewShadowFacebook];
}

-(BOOL) isTextfieldError
{
    if ((![[FormatError sharedInstance] isValidNotNullString:self.textfieldUsername.text]) ||
        (![[FormatError sharedInstance] isValidNotNullString:self.textfieldPassword.text]))
        
        return YES;
    
    else
        return NO;
}

-(BOOL) isLoginSuccessfull:(NSString*)username password:(NSString*)password {

    NSArray *users = [[SQLManager sharedInstance] findUserByUsername:username];
    User *user = [[User alloc] init];
    
    if ([users count] > 0)
    {
        user = [users objectAtIndex:0];
        return ([user.password isEqualToString:password] ? YES : NO);
    } else {
        NSLog(@"User doesnt exist in database");
        return NO;
    }
}

-(void) showAlert:(NSString *)title message:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Retry" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - IBAction

- (IBAction)pushConnect:(id)sender {
    
    if ([self isTextfieldError])
    {
        [self showAlert:@"Invalid Sign In Information" message:@"Seems there are problems with your sign in information"];
    } else {
        
        if (![self isLoginSuccessfull:self.textfieldUsername.text password:self.textfieldPassword.text]) {
            [self showAlert:@"Invalid Sign In Information" message:@"User/Password incorrect! Try again!"];
        } else {
            
            NSMutableArray *arrayUser = [[SQLManager sharedInstance] findUserByUsername:self.textfieldUsername.text];
            User *user = [[User alloc] init];
            user = [arrayUser objectAtIndex:0];
            
            [[UserDefaults sharedInstance] saveUserDefaults:user];
            
            self.viewController = [[JASidePanelController alloc] init];
            [self.viewController setShouldDelegateAutorotateToVisiblePanel:NO];
            
            SidebarViewController *sidebarViewController = [[SidebarViewController alloc] init];
            ProductListViewController *productListViewController = [[ProductListViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:productListViewController];
            
            [self.viewController setLeftPanel:sidebarViewController];
            [self.viewController setCenterPanel:navigationController];
            
            [self.navigationController presentViewController:self.viewController animated:YES completion:nil];
        }
    }
}

- (IBAction)pushSignUpButton:(id)sender {
    
    SignUpViewController *signupViewController = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    [self.navigationController pushViewController:signupViewController animated:YES];
}
@end
