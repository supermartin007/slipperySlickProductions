//
//  SignUpViewController.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/21/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcomeView.h"
#import <QuartzCore/QuartzCore.h>
#define signUpAPI @"https://ssproductions.com/beta/api/apiregister"

@interface SignUpViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableData *signUpMutableData;
}

@property (weak, nonatomic) IBOutlet UIButton *outletOfBtnBack;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *outletOfSubmitBtn;



- (IBAction)submitBtn:(id)sender;


-(void)signUp;

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data;

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
