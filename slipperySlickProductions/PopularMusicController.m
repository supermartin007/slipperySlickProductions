//
//  PopularMusicController.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 9/11/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "PopularMusicController.h"

@interface PopularMusicController ()

@end

@implementation PopularMusicController
@synthesize musicImgs,musicName,musicTime,musicArtist,musicViews;

- (void)viewDidLoad
{
    self.navigationItem.title = @"POPULAR MUSIC";
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
    
    btnNext1.frame = CGRectMake(5, 5, 20,20);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;
       
    musicArtist = [NSArray arrayWithObjects:@"Olivia Holt",@"Sabrina Carpenter",@"Lucy Hale",@"Jordon Fisher",@"Miley Cyrus",@"Justin Martin", nil ];
    musicName = [NSArray arrayWithObjects:@"Kenny Loggins Talks Footloose",@"Made with the Flaxen Hair.mp3",@"Footloose:Blue-Ray",@"Footloose:Than & Now",@"I am super Girl",@"All is Well", nil];
    musicImgs = [NSArray arrayWithObjects: @"firstImage640*250.png",@"no2.jpg",@"secImage640*250.jpg",@"secImg.png",@"firstImg.png",@"no2.jpg",nil];
    musicViews = [NSArray arrayWithObjects:@"6,314",@"1,142",@"3,475",@"5,475", nil];
    musicTime = [NSArray arrayWithObjects:@"6:33",@"2:56",@"3:54",@"2:50", nil];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [musicImgs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *musicCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"musicCell"];

    musicCell.layoutMargins = UIEdgeInsetsZero;
    musicCell.preservesSuperviewLayoutMargins = false;
    _musicTableView.separatorInset = UIEdgeInsetsZero;

    UIImageView *lblImg = [[UIImageView alloc]init];
    lblImg.frame = CGRectMake(5, 5, self.view.frame.size.width-10, 95);
    lblImg.image = [UIImage imageNamed:[musicImgs objectAtIndex:indexPath.row]];
    //  lblImg.contentMode = UIViewContentModeScaleAspectFit;
    [musicCell.contentView addSubview:lblImg];

    UILabel *albumCat = [UILabel new];
    albumCat.frame = CGRectMake(15, 40, 150, 25);
    [albumCat setTextColor:[UIColor whiteColor]];
    albumCat.font = [UIFont systemFontOfSize:14];
    //[albumCat setBackgroundColor:[UIColor whiteColor]];
    [musicCell.contentView addSubview: albumCat] ;
    albumCat.text = musicArtist[indexPath.row];

    UILabel *lblTrack = [UILabel new];
    lblTrack.frame = CGRectMake(15, 60, 250, 25);
    [lblTrack setTextColor:[UIColor whiteColor]];
    lblTrack.font = [UIFont systemFontOfSize:14];
    //[lblTrack setBackgroundColor:[UIColor whiteColor]];
    [musicCell.contentView addSubview: lblTrack];
    lblTrack.text = musicName[indexPath.row];

    [musicCell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return musicCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PlayingMusic *select = [self.storyboard instantiateViewControllerWithIdentifier:@"selectedSong"];
//    
//    select.strImage = musicImgs[indexPath.row];
//    //select.strNavigationTitle = musicName[indexPath.row];
//    select.strSongTotalTime = musicTime[indexPath.row];
//    select.strArtistName = musicArtist[indexPath.row];
//
//    [self.navigationController pushViewController:select animated:NO];
}

@end
