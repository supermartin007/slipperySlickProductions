//
//  ForgotPasswordViewController.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/21/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()
{
    int number;
}

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad
{
    _emailVerify.delegate = self;
    
    _outletOfSendVerificationCode.layer.borderWidth = 1.5f;
    _outletOfSendVerificationCode.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Forgot Password";
     // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_emailVerify resignFirstResponder ];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_emailVerify resignFirstResponder];
    
    return YES;
}

-(void)ForgotPassword
{
    number = arc4random() % 1000000;
    
    NSLog(@"showToken is %i",number);
    
    NSString *post = [NSString stringWithFormat:@"email=%@&token=%d",_emailVerify.text,number];
    NSLog(@"post is %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:forgotPasswordAPI]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if( theConnection )
    {
        NSLog(@"Got Connection");
        
    }
    else
    {
        NSLog(@"lost Connection");
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    forgotPasswordData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSLog(@" data is %@",data);
    
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    forgotPasswordData = [[NSMutableData alloc]initWithData:data];
    
    NSLog(@"forgotPasswordData is %@",forgotPasswordData);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id result = [NSJSONSerialization JSONObjectWithData:forgotPasswordData options:kNilOptions error:nil];
    NSLog(@"result is %@",result);
    
    BOOL success = [[result objectForKey:@"success"] boolValue];
    
    NSString *errorAlert = [result objectForKey:@"error"];
    
    NSLog(@"errorAlert is %@",errorAlert);
    
    if (success)
    {
        VerifyCodeController *verify = [self.storyboard instantiateViewControllerWithIdentifier:@"verify"];
        verify.strEmail = _emailVerify.text;
        verify.strToken = number;
        
        NSLog(@"strEmail is %@",verify.strEmail);
        NSLog(@"strToken is %d",verify.strToken);
        
        [self.navigationController pushViewController:verify animated:NO];
        
        _emailVerify.text = @"";
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (IBAction)sendVerificationCodeBtn:(id)sender
{
    if ([_emailVerify.text isEqualToString:@""])
    {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Fill Email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [self ForgotPassword];
        NSLog(@"Token generated");
    }
}
@end
