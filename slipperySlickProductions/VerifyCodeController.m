//
//  VerifyCodeController.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 8/10/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "VerifyCodeController.h"

@interface VerifyCodeController ()

@end

@implementation VerifyCodeController
@synthesize strEmail,strToken;


- (void)viewDidLoad
{
    _outletOfVerificationCode.layer.borderWidth = 1.5f;
    _outletOfVerificationCode.layer.borderColor = [[UIColor whiteColor] CGColor];
    
   _textFiledOfVerificationCode.delegate = self;

    [super viewDidLoad];
    
    
    NSLog(@"strToken is %d",strToken);
    NSLog(@"strEmail is %@ ",strEmail);
    
    
    self.navigationItem.title = @"Verify Code";
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textFiledOfVerificationCode resignFirstResponder ];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textFiledOfVerificationCode resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)verificationBtn:(id)sender
{
    if ([_textFiledOfVerificationCode.text isEqual:[NSString stringWithFormat:@"%d",strToken]])
    {
        NSLog(@"token matched ");
        ResetPassword *reset = [self.storyboard instantiateViewControllerWithIdentifier:@"resetPassword"];
        reset.resetStrEmail = strEmail;
        [self.navigationController pushViewController:reset animated:NO];
        _textFiledOfVerificationCode.text = @"";
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Wrong Verification Code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}
@end
