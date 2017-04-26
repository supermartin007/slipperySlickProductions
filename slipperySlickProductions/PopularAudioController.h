//
//  PopularAudioController.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 9/11/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingMusic.h"
#import "MBProgressHUD.h"

@interface PopularAudioController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *audioTableView;

@property(nonatomic,strong) NSArray *audioImgs;
@property(nonatomic,strong) NSArray *audioArtist;
@property(nonatomic,strong) NSArray *audioName;
@property(nonatomic,strong) NSArray *audioViews;
@property(nonatomic,strong) NSArray *audioTime;


@end
