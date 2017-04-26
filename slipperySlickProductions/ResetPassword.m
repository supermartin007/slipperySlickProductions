//
//  ResetPassword.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 8/11/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "ResetPassword.h"

@interface ResetPassword ()

@end

@implementation ResetPassword
@synthesize passwordNew,confirmPassword,resetStrEmail;

- (void)viewDidLoad
{
    _outletBtnResetPassword.layer.borderWidth = 1.5f;
    _outletBtnResetPassword.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    passwordNew.delegate = self;
    confirmPassword.delegate = self;
    
    [super viewDidLoad];
   
    self.navigationItem.title = @"Reset Password";
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [passwordNew resignFirstResponder ];
    [confirmPassword resignFirstResponder ];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [passwordNew resignFirstResponder ];
    [confirmPassword resignFirstResponder ];

    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reset
{
    NSString *post = [NSString stringWithFormat:@"email=%@&password=%@",resetStrEmail,passwordNew.text];
    NSLog(@"post is %@ %@  ",resetStrEmail,passwordNew.text);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:ResetPasswordAPI]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (theConnection)
    {
        NSLog(@"theConnection is succesful");
        
        resetPasswordData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection failed");
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    resetPasswordData = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSLog(@" data is %@",data);
    
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    resetPasswordData = [[NSMutableData alloc]initWithData:data];
    
    NSLog(@"resetPasswordData is %@",resetPasswordData);
}

// This method receives the error report in case of connection is not made to server.
// This method is used to process the data after connection has made successfully.

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id result = [NSJSONSerialization JSONObjectWithData:resetPasswordData options:kNilOptions error:nil];
    NSLog(@"result is %@",result);
    
    BOOL success = [[result objectForKey:@"success"] boolValue];
    
    NSString *errorAlert = [result objectForKey:@"error"];
    
    NSLog(@"errorAlert is %@",errorAlert);
    
    if(success)
    {
        NSLog(@"success");
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password Changed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
       
        passwordNew.text = @"";
        confirmPassword.text = @"";
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:passwordNew])
    {
        if ([string isEqualToString:@" "] )
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password can't be filled with blank space" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
            return NO;
        }
    }
    if ([textField isEqual:confirmPassword])
    {
        if ([string isEqualToString:@" "] )
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Confirm Password can't be filled with blank space" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
            return NO;
        }
    }
    return YES;
}

- (BOOL)strongPassword:(NSString *)yourText
{
    BOOL strongPwd = YES;
    
    //Checking length
    if([yourText length] >4)
    strongPwd = YES;
    
    return strongPwd;
}

- (IBAction)resetPasswordBtn:(id)sender
{
    if ([passwordNew.text isEqual:@""] && [confirmPassword.text isEqual:@""])
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"TextFields are mandatory " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else if ([passwordNew.text isEqual:@""])
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Fill Password " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else if ([confirmPassword.text isEqual:@""])
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Fill confirm Password " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else if (![passwordNew.text isEqual:confirmPassword.text])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password and confirm Password does not match" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else  if ( ![self strongPassword:passwordNew.text])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Invalid Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self reset];
    }
}

@end
