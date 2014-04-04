//
//  SignUpViewController.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"

@class JASidePanelController;

@interface SignUpViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,strong) JASidePanelController *viewController;

@property (weak, nonatomic) IBOutlet UIView *viewShadowRegister;
@property (weak, nonatomic) IBOutlet UIView *viewShadowFacebook;

@property (weak, nonatomic) IBOutlet UITextField *textfieldUsername;
@property (weak, nonatomic) IBOutlet UITextField *textfieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textfieldPassword;

@property (weak, nonatomic) IBOutlet UIButton *buttonFacebook;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;

- (IBAction)pushLoginButton:(id)sender;
- (IBAction)pushNextButton:(id)sender;


@end
