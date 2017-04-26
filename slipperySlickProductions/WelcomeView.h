//
//  WelcomeView.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/13/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "DiscoverViewController.h"

extern MPMoviePlayerController *objOfmoviePlayer;
extern BOOL isToPlay;

@interface WelcomeView : UIViewController<UITabBarControllerDelegate,MBProgressHUDDelegate>
{
    NSString *strUser;
    NSString *strPass;
    NSMutableData *welcomeMutableData;
    MBProgressHUD *HUD;
}


@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UIView *viewObj;

- (IBAction)LoginBtn:(id)sender;
- (IBAction)SignupBtn:(id)sender;

@property (nonatomic,strong) UITabBarController *tabBarController;

//@property(nonatomic,strong) MPMoviePlayerController *objOfmoviePlayer;
//-(void)automaticallyLogin;

@end


