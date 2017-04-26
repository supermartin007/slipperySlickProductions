//
//  PopularMusicController.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 9/11/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingMusic.h"
#import "MBProgressHUD.h"

@interface PopularMusicController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

@property(nonatomic,strong) NSArray *musicImgs;
@property(nonatomic,strong) NSArray *musicArtist;
@property(nonatomic,strong) NSArray *musicName;
@property(nonatomic,strong) NSArray *musicViews;
@property(nonatomic,strong) NSArray *musicTime;
@property (weak, nonatomic) IBOutlet UITableView *musicTableView;

@end
