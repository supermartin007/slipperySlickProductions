//
//  ViewController.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/9/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForgotPasswordViewController.h"
#import "WelcomeView.h"
#import "SignUpViewController.h"
#define loginAPI @"https://ssproductions.com/beta/api/apilogin"
#import "MBProgressHUD.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ProfileViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <TwitterKit/TwitterKit.h>

extern FBSDKLoginManager *login;


@class ProfileViewController;
@class DiscoverViewController;
@class SettingViewController;
@class AlbumViewController;
@interface LoginViewController : UIViewController <UITextFieldDelegate,UITabBarControllerDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,MBProgressHUDDelegate>

{
    ProfileViewController *profileVC;
    AlbumViewController *albumVC;
    SettingViewController *settingVC;
    DiscoverViewController *discoverVC;
    NSMutableData *loginMutableData;
    NSError *error1;
    
}

@property (weak, nonatomic) IBOutlet UITextField *userNameTxtField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UIButton *btnFb;

@property (weak, nonatomic) IBOutlet UIButton *outletOfBackBtn;

- (IBAction)btnLogin:(id)sender;
- (IBAction)btnFb:(id)sender;
- (IBAction)btnForgotPassword:(id)sender;
- (IBAction)backBtn:(id)sender;
- (IBAction)twitterBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtFeildPassword;
@property (weak, nonatomic) IBOutlet UIButton *twitterBtnOutlet;


@property (weak, nonatomic) IBOutlet UIView *subview;

@property (nonatomic,strong) UITabBarController *tabBarController;
//@property(nonatomic,strong) MPMoviePlayerController *objOfmoviePlayer;
@property(nonatomic,strong) NSMutableArray *objArray;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@end

