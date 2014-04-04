//
//  SignInViewController.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 01/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JASidePanelController;

@interface SignInViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,strong) JASidePanelController *viewController;

@property (strong, nonatomic) IBOutlet UITextField *textfieldUsername;
@property (strong, nonatomic) IBOutlet UITextField *textfieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonConnect;
@property (weak, nonatomic) IBOutlet UIButton *buttonFacebook;
@property (weak, nonatomic) IBOutlet UIView *viewShadowConnect;
@property (weak, nonatomic) IBOutlet UIView *viewShadowFacebook;

- (IBAction)pushConnect:(id)sender;
- (IBAction)pushSignUpButton:(id)sender;

@end
