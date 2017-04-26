//
//  ViewController.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/9/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "LoginViewController.h"
#import "SettingViewController.h"
#import "DiscoverViewController.h"
#import "Reachability.h"

FBSDKLoginManager *login = nil;


@interface LoginViewController ()
{
    MBProgressHUD *HUD;
    NSString *strObj;
  
}
@end

@implementation LoginViewController
//@synthesize objOfmoviePlayer;
@synthesize userNameTxtField,passwordTxtField,btnLogin,btnFb;                                 
@synthesize txtFeildPassword,txtFieldUserName,outletOfBackBtn;
@synthesize coverView;

- (void)viewDidLoad
{
   // coverView.hidden = YES;
    isToPlay = YES;
    self.navigationController.navigationBar.hidden = YES;
   
    txtFeildPassword.delegate = self;
    txtFieldUserName.delegate = self;
    
    outletOfBackBtn.layer.borderWidth = 1.5f;
    outletOfBackBtn.layer.cornerRadius = 5.0f;
    outletOfBackBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    UIView *line1 = [UIView new];
    line1.frame = CGRectMake((self.view.frame.size.width/2)-((286.0/375.0)*self.view.frame.size.width/2), (190.0/667.0)*self.view.frame.size.height, (286.0/375.0)*self.view.frame.size.width, 1.0);
    [line1 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:line1];
    NSLog(@"width is %f",self.view.frame.size.width);
    
    UIView *line2 = [UIView new];
    line2.frame = CGRectMake((self.view.frame.size.width/2)-((286.0/375.0)*self.view.frame.size.width/2), (282.0/667.0)*self.view.frame.size.height, (286.0/375.0)*self.view.frame.size.width, 1.0);
    [line2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:line2];
     NSLog(@"height is %f",self.view.frame.size.height);
    
      [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:28.0/255 green:28.0/255 blue:28.0/255 alpha:1.0]];

    NSAttributedString * placeholderUsername = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue" size:17.0]}];
    userNameTxtField.attributedPlaceholder = placeholderUsername;
    
    NSAttributedString * placeholderPassword = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:17.0]}];
    passwordTxtField.attributedPlaceholder = placeholderPassword;
    
    btnLogin.layer.borderWidth = 1.5;
    btnLogin.layer.cornerRadius = 6;
    
    btnFb.layer.borderWidth = 1.5;
    btnFb.layer.cornerRadius = 6;
    
    _twitterBtnOutlet.layer.borderWidth = 1.5;
    _twitterBtnOutlet.layer.cornerRadius = 6;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appplicationIsActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)appplicationIsActive:(NSNotification *)notification
{
    NSLog(@"Application Did Become Active in login screen");
    
    if (isToPlay)
    {
         [objOfmoviePlayer play];
    }
    else
    {
         [objOfmoviePlayer stop];
    }
   
}

-(void)viewWillAppear:(BOOL)animated
{
    isToPlay = YES;
    
    self.navigationController.navigationBar.hidden = YES;
    
    strObj = [[NSBundle mainBundle]pathForResource:@"Official Slippery Slick Productions Intro" ofType:@"mp4"];
    objOfmoviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:strObj]];
    objOfmoviePlayer.view.frame = _subview.frame;
    
    NSLog(@"%@",NSStringFromCGRect(_subview.frame));
    
    objOfmoviePlayer.scalingMode = MPMovieControlStyleFullscreen;
    [_subview addSubview:objOfmoviePlayer.view];
    [objOfmoviePlayer play];
   
}

#pragma mark - Execution code

- (void)myTask
{
    
    sleep(1.5);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txtFeildPassword resignFirstResponder ];
    [txtFieldUserName resignFirstResponder ];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
     [txtFeildPassword resignFirstResponder];
     [txtFieldUserName resignFirstResponder];
    
    return YES;
}

-(void)login
{
    _objArray = [[NSMutableArray alloc]init];
    
    NSString *post = [NSString stringWithFormat:@"email=%@&password=%@",userNameTxtField.text ,passwordTxtField.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:loginAPI]];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if( theConnection )
    {
        
        NSLog(@"theConnection is  %@",theConnection);
    }
   
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"response is %@", response);
    
    loginMutableData = [[NSMutableData alloc]init];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    loginMutableData = [[NSMutableData alloc]initWithData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    id result = [NSJSONSerialization JSONObjectWithData:loginMutableData options:kNilOptions error:nil];
    NSLog(@"result is %@",result);
    
    BOOL success = [[result objectForKey:@"success"] boolValue];
    
    NSArray *data = [result valueForKey:@"data"];
    NSLog(@"data is %@",data);
    
    NSString *errorAlert = [result objectForKey:@"error"];
    NSLog(@"errorAlert is %@",errorAlert);
    
    if (success)
    {
        
        NSLog(@"login in else part");
        
         [_objArray removeAllObjects];
        
//        for (NSDictionary *bpdict in data)
//        {
        NSLog(@"for loop %@", data);
            
        [_objArray addObject:data];
            
        NSLog(@" _objArray is %lu",(unsigned long)_objArray);
            
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
        NSString *fname = [data valueForKey:@"firstname"];
        NSString *lname = [data valueForKey:@"lastname"];
        //NSString *loginId = [data valueForKey:@"id"];
        
       // NSLog(@"firstname and lastname is %@ %@ %@",fname,lname,loginId);
        NSLog(@"firstname and lastname is %@ %@",fname,lname);

        NSString *fullname = [NSString stringWithFormat:@"%@ %@", fname,lname];
            
            
            [defaults setValue:[data valueForKey:@"email"] forKey:@"email"];
            
            [defaults setValue:fullname forKey:@"fullname"];
            
            [defaults setValue:[data valueForKey:@"username"] forKey:@"user_name"];
            [defaults setValue:[data valueForKey:@"id"] forKey:@"uid"];
            [defaults setValue:[data valueForKey:@"normal"] forKey:@"usertype"];
            [defaults synchronize];
            
            [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"Relogin"];
            [[NSUserDefaults standardUserDefaults]synchronize];

        isToPlay = NO;
        
        [objOfmoviePlayer stop];
        [self tabBar];
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


-(void)tabBar
{
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    [self.tabBarController.tabBar setTranslucent:NO];
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.0000 green:0.7020 blue:0.8980 alpha:1.0];
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    // first tab has view controller in navigation controller
    ProfileViewController* restaurantTable = [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
    restaurantTable.tabBarItem.image = [[UIImage imageNamed:@"profileUnselected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    restaurantTable.tabBarItem.title = @"Profile";
    [restaurantTable.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:12],NSFontAttributeName,nil]forState:UIControlStateNormal];
    restaurantTable.tabBarItem.selectedImage = [UIImage imageNamed:@"profileSelected.png"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:restaurantTable];
    [viewControllers addObject:navController];
    
    DiscoverViewController* searchView = [self.storyboard instantiateViewControllerWithIdentifier:@"discover"];
    searchView.tabBarItem.image = [[UIImage imageNamed:@"discover.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchView.tabBarItem.title = @"Discover";
    [searchView.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:12],NSFontAttributeName,nil]forState:UIControlStateNormal];
    searchView.tabBarItem.selectedImage = [UIImage imageNamed:@"discoverSelected.png"];
    UINavigationController *navTosearchView = [[UINavigationController alloc] initWithRootViewController:searchView];
    [viewControllers addObject:navTosearchView];
    
    SettingViewController* settingView = [self.storyboard instantiateViewControllerWithIdentifier:@"setting"];
    settingView.tabBarItem.image = [[UIImage imageNamed:@"settingUnselected.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    settingView.tabBarItem.title = @"Settings";
    [settingView.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:12],NSFontAttributeName,nil]forState:UIControlStateNormal];
    settingView.tabBarItem.selectedImage = [UIImage imageNamed:@"settingSelected.png"];
    
    UINavigationController *navTosettingView = [[UINavigationController alloc] initWithRootViewController:settingView];
    [viewControllers addObject:navTosettingView];
    
     [self.tabBarController setViewControllers:viewControllers];
    
    // add tabbar and show
//    [[self view] addSubview:[self.tabBarController view]];
    
    [self.view addSubview:[self.tabBarController view]];
    
   [self.navigationController pushViewController:self.tabBarController animated:YES];
    
    //[self.navigationController presentViewController:self.tabBarController animated:NO completion:nil];
 
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:txtFieldUserName])
    {
        if ([string isEqualToString:@" "] )
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Username can't be filled with blank space" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];

            return NO;
        
        }
    }
    if ([textField isEqual:txtFeildPassword])
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

- (IBAction)btnLogin:(id)sender
{

    if([txtFieldUserName.text isEqualToString:@""] && [txtFeildPassword.text isEqualToString:@""] )
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"All text fields are mandatory" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
     else if ([txtFieldUserName.text isEqualToString:@""])
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Fill your username" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    }
    
    else if ([txtFeildPassword.text isEqualToString:@""])
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Fill your password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    }
   
    else
    {
        coverView.hidden = YES;
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus internetStatus = [reachability currentReachabilityStatus];
        
        if (internetStatus != NotReachable)
        {
            //my web-dependent code
            NSLog(@"Valid Internet Connection");
            [self login];
            
        }
        else
        {
           // coverView.hidden = YES;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Network Error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
    }
}

- (IBAction)btnFb:(id)sender
{
    
    login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *errorObj)
    {
        if (errorObj)
        {
            // Process error
            NSLog(@"error %@",errorObj);
        }
        else if (result.isCancelled)
        {
            // Handle cancellations
            NSLog(@"Cancelled");
            [objOfmoviePlayer play];

        }
        else
        {
            if ([result.grantedPermissions containsObject:@"email"])
            {
                [objOfmoviePlayer stop];
                
                NSLog(@"%@",result);
                NSLog(@"Correct");
                               
                if ([FBSDKAccessToken currentAccessToken])
                {
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,id result, NSError *error)
                    {
                               
                        if (!error)
                         {
                             NSLog(@"fetched user:%@", result);
                            
                             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                             
                             NSString *idForFb = [result valueForKey:@"id"];
                             
                            [defaults setValue:[result valueForKey:@"name"] forKey:@"DisplayName"];
                             
                             [defaults setValue:@"facebook" forKey:@"usertype"];
                            
                             // saving facebook image in document directory
                             
                             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                             NSString *documentsDirectory = [paths objectAtIndex:0];
                             NSString* path = [documentsDirectory stringByAppendingPathComponent:@"test.png"];
                             NSLog(@"path is %@",path);
                             
                             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?", idForFb]];
                             NSData *data = [NSData dataWithContentsOfURL:url];
                             UIImage *profilePic = [[UIImage alloc] initWithData:data];
                             NSLog(@"profilePic is %@",profilePic);
                             [data writeToFile:path atomically:YES];
                           
                            [defaults setValue:idForFb forKey:@"user_name"];
                            
                             
                             [defaults synchronize];
                             
                             [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"Relogin"];
                             [[NSUserDefaults standardUserDefaults]synchronize];

                             isToPlay = NO;
                             
                             [self tabBar];
                             
                         }
                        
                        [objOfmoviePlayer stop];
                     }];
                }
            }
        }
    }];
    
    [login logOut];
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [[NSUserDefaults standardUserDefaults]setBool:false forKey:@"Relogin"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
}

- (IBAction)btnForgotPassword:(id)sender
{
    ForgotPasswordViewController *forgot = [self.storyboard instantiateViewControllerWithIdentifier:@"pushgo"];
    [self.navigationController pushViewController:forgot animated:NO];
    [objOfmoviePlayer stop];
}

- (IBAction)backBtn:(id)sender
{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (IBAction)twitterBtn:(id)sender
{
    [objOfmoviePlayer stop];
    
    [[Twitter sharedInstance] logInWithCompletion:^
     (TWTRSession *session, NSError *error)
    {
         if (session)
         {
             [objOfmoviePlayer stop];
   
             NSLog(@"signed in as %@", [session userName]);
             
             [[NSUserDefaults standardUserDefaults] setValue:@"Twitter" forKey:@"usertype"];
             
             [[NSUserDefaults standardUserDefaults]setValue:[session userName] forKey:@"user_name"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             
             [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"Relogin"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             
             isToPlay = NO;
             [self tabBar];
         }
         else
         {
             NSLog(@"error: %@", [error localizedDescription]);
         }
         
    }];
    [objOfmoviePlayer stop];

}

@end
