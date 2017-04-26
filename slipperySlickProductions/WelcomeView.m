//
//  WelcomeView.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/13/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "WelcomeView.h"

MPMoviePlayerController *objOfmoviePlayer = nil;
BOOL isToPlay = YES;

@interface WelcomeView ()
{
    NSString *strObj;
    
}
@end

@implementation WelcomeView
//@synthesize objOfmoviePlayer;


- (void)viewDidLoad
{
    NSLog(@"Welcome View");
    
    isToPlay = YES;
    
    [super viewDidLoad];
    
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appplicationIsActive:) name:UIApplicationDidBecomeActiveNotification object:nil];

}

- (void)appplicationIsActive:(NSNotification *)notification
{
    NSLog(@"Application Did Become Active in welcome screen is %d",isToPlay);
    
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
    //[self automaticallyLogin];
    
    self.navigationController.navigationBar.hidden = YES;

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Relogin"] == NO)
    {
        
        strObj = [[NSBundle mainBundle]pathForResource:@"Official Slippery Slick Productions Intro" ofType:@"mp4"];
        objOfmoviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:strObj]];
        objOfmoviePlayer.view.frame = _subView.frame;
        
        NSLog(@"%@",NSStringFromCGRect(_subView.frame));
        
        objOfmoviePlayer.scalingMode = MPMovieControlStyleFullscreen;
        [_subView addSubview:objOfmoviePlayer.view];
        
        [objOfmoviePlayer play];
    }
    else
    {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Relogin"] == YES)
        {
            isToPlay = NO;
            
            [objOfmoviePlayer stop];
            
            [self goToTabBar];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults]setBool:false forKey:@"Relogin"];
        }

    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [objOfmoviePlayer stop];
}

//#pragma mark - Execution code
//
//- (void)myTask
//{
//    
//    sleep(10);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)goToTabBar
{
   [self.tabBarController removeFromParentViewController];
    
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController viewWillAppear:NO];
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
    
    //add tabbar and show
    [[self view] addSubview:[self.tabBarController view]];
    
    
    //  [self.navigationController presentViewController:self.tabBarController animated:NO completion:nil];
    [self.navigationController pushViewController:self.tabBarController animated:NO];
    //[self.navigationController presentedViewController];
}

- (IBAction)LoginBtn:(id)sender
{
    NSLog(@"LoginBtn Clicked");
    
    LoginViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"go"];
    [self.navigationController pushViewController:login animated:NO];
    [objOfmoviePlayer stop];
}

- (IBAction)SignupBtn:(id)sender
{
    NSLog(@"SignupBtn Clicked ");
    
    SignUpViewController *registerView = [self.storyboard instantiateViewControllerWithIdentifier:@"move"];
    [self.navigationController pushViewController:registerView animated:NO];
    [objOfmoviePlayer stop];
  
}
@end
