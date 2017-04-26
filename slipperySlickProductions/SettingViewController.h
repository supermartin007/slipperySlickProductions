//
//  SettingViewController.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/13/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "welcomeView.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>

extern NSString *strId;

@interface SettingViewController : UIViewController<AVAudioPlayerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *outletOfNotificationBtn;
@property(strong,nonatomic) NSString *strStopAudio;

- (IBAction)notificationsBtn:(id)sender;
- (IBAction)signOutBtn:(id)sender;
- (IBAction)recordVideo:(id)sender;

@end
