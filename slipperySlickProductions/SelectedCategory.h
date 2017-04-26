//
//  SelectedCategory.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/13/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingMusic.h"
#import "MBProgressHUD.h"
#import "customCell.h"

extern BOOL displayImage;
extern  NSURL *url;
extern NSString *userId;

@interface SelectedCategory : UIViewController <UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
    NSMutableData *songsMutableData;
}

@property(nonatomic,strong) NSArray *CategoryImg;
@property(nonatomic,strong) NSArray *CategorySong;
@property(nonatomic,strong) NSArray *CategoryTime;
@property(nonatomic,strong) NSArray *CategoryArtist;
@property(nonatomic,strong) NSArray *CategoryViews;

@property(nonatomic,strong)NSString *strContainsAlbumID;
@property(nonatomic,strong)NSString *strContainsAlbumSong;
@property(nonatomic,strong)NSMutableArray *strOfSongArray;
@property(nonatomic,strong)NSMutableArray *topSongs;

@property (weak, nonatomic) IBOutlet UITableView *selectedCategoryTableView;

@end
