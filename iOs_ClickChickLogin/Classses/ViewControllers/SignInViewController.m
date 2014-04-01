//
//  SignInViewController.m
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import "SignInViewController.h"

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

#pragma mark - Private Methods

-(void) setupAppearence {
    [[UICustomize sharedInstance] setLoginStyleButton:self.buttonConnect color:[UIColors kCyanColor]];
    [[UICustomize sharedInstance] setLoginStyleButton:self.buttonFacebook color:[UIColors kBlueColor]];
    [[UICustomize sharedInstance] setLoginStyleTextfield:self.textfieldUsername];
    [[UICustomize sharedInstance] setLoginStyleTextfield:self.textfieldPassword];
    
    [[UICustomize sharedInstance] setViewAsShadow:self.viewShadowConnect];
    [[UICustomize sharedInstance] setViewAsShadow:self.viewShadowFacebook];
}

- (IBAction)pushConnect:(id)sender {
}
@end
