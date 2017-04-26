//
//  LibraryViewController.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/10/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PlayingMusic.h"
#import "MBProgressHUD.h"
#define DiscoverGenreAPI @"https://ssproductions.com/beta/api/getgenre"
#import "customCell.h"
#import "GenreViewController.h"
#import "PopularMusicController.h"
#import "PopularAudioController.h"

@interface DiscoverViewController : UIViewController

- (IBAction)genresBtn:(id)sender;
- (IBAction)musicBtn:(id)sender;
- (IBAction)audioBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *discoverFirst;
@property (weak, nonatomic) IBOutlet UIButton *discoverSecond;
@property (weak, nonatomic) IBOutlet UIButton *discoverThird;
@property (weak, nonatomic) IBOutlet UIView *discoverViewObj;





@end
