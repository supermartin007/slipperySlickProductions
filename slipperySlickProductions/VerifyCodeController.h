//
//  VerifyCodeController.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 8/10/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResetPassword.h"

@interface VerifyCodeController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFiledOfVerificationCode;
@property (weak, nonatomic) IBOutlet UIButton *outletOfVerificationCode;
@property(nonatomic,strong) NSString *strEmail;
@property(nonatomic) int strToken;

- (IBAction)verificationBtn:(id)sender;

@end
