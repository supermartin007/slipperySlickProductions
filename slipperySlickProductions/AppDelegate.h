//
//  AppDelegate.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/9/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) UITabBarController *tabBarController;
@property (nonatomic,strong) UINavigationController *navigationController;
@property (nonatomic,strong) UIStoryboard *storyboard;

//@property(nonatomic,strong) MPMoviePlayerController *objOfmoviePlayer;
@end

