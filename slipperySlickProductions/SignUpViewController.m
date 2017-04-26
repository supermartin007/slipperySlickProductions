//
//  SignUpViewController.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/21/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()


@end

@implementation SignUpViewController
@synthesize outletOfBtnBack;

- (void)viewDidLoad
{
    outletOfBtnBack.layer.borderWidth=1.5f;
    outletOfBtnBack.layer.borderColor=[[UIColor whiteColor] CGColor];
    
    _outletOfSubmitBtn.layer.borderWidth = 1.5f;
    _outletOfSubmitBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [super viewDidLoad];
    
    _firstName.delegate = self;
    _lastName.delegate = self;
    _email.delegate = self;
    _userName.delegate = self;
   _password.delegate = self;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
   
}
-(void)signUp
{
    
    NSString *post = [NSString stringWithFormat:@"firstname=%@&lastname=%@&username=%@&email=%@&password=%@",_firstName.text ,_lastName.text,_userName.text,_email.text,_password.text];
    NSLog(@"post is %@ %@ %@ %@ %@ ",_firstName.text,_lastName.text,_email.text,_userName.text,_password.text);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:signUpAPI]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];

}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"response in signUpviewcontroller is %@",response);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSLog(@" data is %@",data);
    
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    
    signUpMutableData = [[NSMutableData alloc]initWithData:data];
    
    NSLog(@"signUpMutableData is %@",signUpMutableData);
}

// This method receives the error report in case of connection is not made to server.
// This method is used to process the data after connection has made successfully.

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    id result = [NSJSONSerialization JSONObjectWithData:signUpMutableData options:kNilOptions error:nil];
    NSLog(@"result is %@",result);
    
    BOOL success = [[result objectForKey:@"success"] boolValue];
    
    NSString *errorAlert = [result objectForKey:@"0"];
                            
    NSLog(@"errorAlert is %@",errorAlert);
    
    if (success)
    {
        
        NSLog(@"sign up in else part");
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:_userName.text forKey:@"usernameKey"];
        [defaults setValue:_email.text forKey:@"emailKey"];
        [defaults synchronize];
        
        LoginViewController *goBackToLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"go"];
        [self.navigationController pushViewController:goBackToLogin animated:NO];
        
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:errorAlert delegate:self cancelButtonTitle:@"Ok"otherButtonTitles: nil];
        [alert show];
        
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)didReceiveMemoryWarning
{     [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_firstName resignFirstResponder ];
    [_lastName resignFirstResponder ];
    [_email resignFirstResponder ];
    [_userName resignFirstResponder ];
    [_password resignFirstResponder ];
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_firstName resignFirstResponder ];
    [_lastName resignFirstResponder ];
    [_email resignFirstResponder ];
    [_userName resignFirstResponder ];
    [_password resignFirstResponder ];
    
    return YES;
    
}

-(BOOL)checkingEmail:(NSString *)checkEmail
{
    NSLog(@"checking Email");
    BOOL var1 = true;
    
    
    if ([checkEmail containsString:@"@"])                                          // if string contains @
    {
        NSArray *myWords = [checkEmail componentsSeparatedByString:@"@"];
        
        //myWords is an array,separate strings by @ and keeping string into array
        
        for (int i = 0; i<[myWords count]; i++)                                    //checks string one by one
        {
            if ([myWords[i] isEqual: @""])  // if string is empty than return false and myWords[i] is a string
               
            {
                var1 = false;
            }
        }
        
        if (var1)
        {
            
            if ([myWords[[myWords count] - 1] containsString:@"."])
            {
                NSLog(@"working %@",myWords[[myWords count] - 1]);
                
                NSArray *myDotWords = [myWords[[myWords count] - 1] componentsSeparatedByString:@"."];
                
                for (int i = 0; i<[myDotWords count]; i++)
                {
                    if ([myDotWords[i] isEqual: @""])
                    {
                        var1 = false;
                    }
                }
            }
            else
            {
                var1 = false;
            }
        }
    }
    else
    {
        var1 = false;
    }
    
    
    return var1;
}

- (BOOL)strongPassword:(NSString *)yourText
{
    BOOL strongPwd = YES;
    
    if([yourText length] > 4)
    strongPwd = YES;
    
    return strongPwd;
}

- (IBAction)submitBtn:(id)sender
{
    if([_firstName.text isEqualToString:@""] || [_lastName.text isEqualToString:@""] || [_email.text isEqualToString:@""] ||[_userName.text isEqualToString:@""] ||  [_password.text isEqualToString:@""])
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"All textfields are mandatory" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
       
    }
    else  if (![self checkingEmail:_email.text] )
    {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Invalid Email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
    }
    
    else  if ( ![self strongPassword:_password.text])
    {
           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Enter Strong Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
           [alert show];
    }
    else
    {
        [self signUp];
      
    }
 }

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:_firstName])
    {
        if ([string isEqualToString:@" "] )
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Firstname can't be filled with blank space" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
            return NO;
        }
    }
    if ([textField isEqual:_lastName])
    {
        if ([string isEqualToString:@" "] )
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"lastname can't be filled with blank space" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
            return NO;
        }
    }
    
    if ([textField isEqual:_email])
    {
        if ([string isEqualToString:@" "] )
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Email can't be filled with blank space" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
            return NO;
        }
    }
    
    if ([textField isEqual:_userName])
    {
        if ([string isEqualToString:@" "] )
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Username can't be filled with blank space" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
            return NO;
        }
    }

    if ([textField isEqual:_password])
    {
        if ([string isEqualToString:@" "] )
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password can't be filled with blank space" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
            return NO;
        }
    }

    return YES;
}

@end
