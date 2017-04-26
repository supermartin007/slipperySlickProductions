//
//  GenreViewController.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 9/11/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PlayingMusic.h"
#import "MBProgressHUD.h"
#define DiscoverGenreAPI @"https://ssproductions.com/beta/api/getgenre"
#import "customCell.h"



@interface GenreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    NSMutableArray *dataArray;
    NSMutableData *discoverData;
}
@property (weak, nonatomic) IBOutlet UITableView *genresTableView;

-(void)discoverCategory;

@end
