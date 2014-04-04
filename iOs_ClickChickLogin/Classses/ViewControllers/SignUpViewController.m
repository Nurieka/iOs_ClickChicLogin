//
//  SignUpViewController.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignInViewController.h"
#import "JASidePanelController.h"
#import "SidebarViewController.h"
#import "ProductListViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    
    [self.textfieldPassword setDelegate:self];
    [self.textfieldEmail setDelegate:self];
    [self.textfieldUsername setDelegate:self];
    
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

# pragma mark - UITextField Delegate Methods

- (BOOL) textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

# pragma mark - Private Methods

-(void) setupAppearence {
    [[UICustomize sharedInstance] setLoginStyleButton:self.buttonNext color:[UIColors kCyanColor]];
    [[UICustomize sharedInstance] setLoginStyleButton:self.buttonFacebook color:[UIColors kBlueColor]];
    [[UICustomize sharedInstance] setLoginStyleTextfield:self.textfieldUsername];
    [[UICustomize sharedInstance] setLoginStyleTextfield:self.textfieldEmail];
    [[UICustomize sharedInstance] setLoginStyleTextfield:self.textfieldPassword];
    
    [[UICustomize sharedInstance] setViewAsShadow:self.viewShadowRegister];
    [[UICustomize sharedInstance] setViewAsShadow:self.viewShadowFacebook];
}


-(BOOL) isTextfieldError
{
    if ((![[FormatError sharedInstance] isValidEmail:self.textfieldEmail.text Strict:NO]) ||
        (![[FormatError sharedInstance] isValidNotNullString:self.textfieldUsername.text]) ||
        (![[FormatError sharedInstance] isValidNotNullString:self.textfieldPassword.text]))
      
        return YES;
    
    else
        return NO;
}


-(void) showAlert:(NSString *)title message:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Retry" otherButtonTitles: nil];
    [alert show];
}

- (BOOL) isUsernameExist:(NSString*)username
{
    NSMutableArray *users = [[NSMutableArray alloc] initWithCapacity:0];
    users = [[SQLManager sharedInstance] findUserByUsername:username];
    
    if ([users count] > 0)
        return YES;
    else
        return NO;
}

# pragma mark - IBAction Methods
- (IBAction)pushLoginButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pushNextButton:(id)sender {
    if ([self isTextfieldError])
    {
        [self showAlert:@"Invalid Sign Up Information" message:@"Seems there are problems with your sign up information"];
    } else {
        
        if ([self isUsernameExist:self.textfieldUsername.text]) {
            [self showAlert:@"Invalid Sign Up Information" message:@"Username has been taken! Change it!"];
        } else {
            
            User *user = [[User alloc] initWithParams:0 username:self.textfieldUsername.text password:self.textfieldPassword.text email:self.textfieldEmail.text];
            
            // Add user to database
            [[SQLManager sharedInstance] addUser:user];
            
            // Before saveUserDefaults, we need user_id
            NSMutableArray *arrayUser = [[SQLManager sharedInstance] findUserByUsername:self.textfieldUsername.text];
            user = [arrayUser objectAtIndex:0];            
            
            // Save user as UserDefaults - User active
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
@end
