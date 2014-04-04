//
//  ProductAddViewController.h
//  iOs_ClickChickLogin
//
//  Created by Roberto Marco on 02/04/14.
//  Copyright (c) 2014 Roberto Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@protocol ProductAddViewControllerDelegate <NSObject>
@required
- (void)insertProduct:(Product*)product;
@end

@interface ProductAddViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) id<ProductAddViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imageProduct;
@property (weak, nonatomic) IBOutlet UITextField *textfieldTitle;
@property (weak, nonatomic) IBOutlet UITextView *textfieldDescription;
@property (weak, nonatomic) IBOutlet UITextField *textfieldPrice;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) Product *editingProduct;
@end
