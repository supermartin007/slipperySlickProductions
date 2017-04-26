//
//  ForgotPasswordViewController.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/21/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "verifyCodeController.h"
#define forgotPasswordAPI @"https://ssproductions.com/beta/api/apiforgotpassword"

@interface ForgotPasswordViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableData *forgotPasswordData;
}

@property (weak, nonatomic) IBOutlet UIButton *outletOfSendVerificationCode;
@property (weak, nonatomic) IBOutlet UITextField *emailVerify;


- (IBAction)sendVerificationCodeBtn:(id)sender;

-(void)ForgotPassword;

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data;

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;




@end
