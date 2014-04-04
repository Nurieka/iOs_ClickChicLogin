//
//  ProductDetailViewController.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ProductAddViewController.h"

@interface ProductDetailViewController : UIViewController <UIAlertViewDelegate,ProductAddViewControllerDelegate>

@property (nonatomic, strong) Product *product;
@property (weak, nonatomic) IBOutlet UILabel *labelUserId;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UIButton *buttonBuy;

@end
