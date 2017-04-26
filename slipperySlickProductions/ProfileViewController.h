//
//  ProfileViewController.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/13/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingMusic.h"
#define PostAPI @"https://ssproductions.com/beta/api/usersongs"
#import "customCell.h"
extern BOOL isValue;

@interface ProfileViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    NSMutableArray *postArray;
    NSMutableData *postData;
}
@property(nonatomic,strong) NSArray *postImg;
@property(nonatomic,strong) NSArray *postSong;
@property(nonatomic,strong) NSArray *postTime;
@property(nonatomic,strong) NSArray *postArtist;
@property(nonatomic,strong) NSArray *postViews;

@property(nonatomic,strong) NSArray *timeLineImg;
@property(nonatomic,strong) NSArray *timeLineSong;
@property(nonatomic,strong) NSArray *timeLineTime;
@property(nonatomic,strong) NSArray *timeLineArtist;
@property(nonatomic,strong) NSArray *timeLineViews;


@property(nonatomic,strong) NSArray *playlistImg;
@property(nonatomic,strong) NSArray *playlistSong;
@property(nonatomic,strong) NSArray *playlistTime;
@property(nonatomic,strong) NSArray *playlistArtist;
@property(nonatomic,strong) NSArray *playlistViews;

@property(nonatomic,strong) NSArray *albumsImg;
@property(nonatomic,strong) NSArray *albumsSong;
@property(nonatomic,strong) NSArray *albumsTime;
@property(nonatomic,strong) NSArray *albumsArtist;
@property(nonatomic,strong) NSArray *albumsViews;

@property(nonatomic,strong) NSArray *audioTrackImg;
@property(nonatomic,strong) NSArray *audioTrackSong;
@property(nonatomic,strong) NSArray *audioTrackTime;
@property(nonatomic,strong) NSArray *audioTrackArtist;
@property(nonatomic,strong) NSArray *audioTrackViews;


@property (weak, nonatomic) IBOutlet UIView *profileImageView;
@property (weak, nonatomic) IBOutlet UIView *profileSubviewObj;

@property (weak, nonatomic) IBOutlet UITableView *postsTableBiew;
@property (weak, nonatomic) IBOutlet UITableView *timeLineTableView;
@property (weak, nonatomic) IBOutlet UITableView *playlistTableView;

@property (weak, nonatomic) IBOutlet UITableView *albumsTableView;



@property (weak, nonatomic) IBOutlet UIView *highlightView;
@property (weak, nonatomic) IBOutlet UIView *bioView;

@property (weak, nonatomic) IBOutlet UILabel *bioUserNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *bioEmail;


@property (weak, nonatomic) IBOutlet UILabel *proflieName;
@property (weak, nonatomic) IBOutlet UILabel *profileEmail;
@property (weak, nonatomic) IBOutlet UILabel *profileUsername;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

- (IBAction)infoBtn:(UIButton *)sender;
- (IBAction)postsBtn:(UIButton *)sender;
- (IBAction)playlistsBtn:(UIButton *)sender;
- (IBAction)albumsBtn:(UIButton *)sender;
- (IBAction)bioBtn:(UIButton *)sender;


//-(void)post;

@end
