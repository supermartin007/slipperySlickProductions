//
//  ResetPassword.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 8/11/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ResetPasswordAPI @"https://ssproductions.com/beta/api/resetpassword"
#import "LoginViewController.h"

@interface ResetPassword : UIViewController<UITextFieldDelegate>
{
    NSMutableData *resetPasswordData;
}

@property (weak, nonatomic) IBOutlet UITextField *passwordNew;

@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

@property (weak, nonatomic) IBOutlet UIButton *outletBtnResetPassword;

@property(nonatomic,strong) NSString *resetStrEmail;

- (IBAction)resetPasswordBtn:(id)sender;

-(void)reset;
// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data;
// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;







@end
