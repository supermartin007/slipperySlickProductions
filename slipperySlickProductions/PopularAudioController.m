//
//  PopularAudioController.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 9/11/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "PopularAudioController.h"

@interface PopularAudioController ()

@end

@implementation PopularAudioController
@synthesize audioImgs,audioName,audioTime,audioArtist,audioViews;


- (void)viewDidLoad
{
    self.navigationItem.title = @"POPULAR AUDIO";
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
    
    btnNext1.frame = CGRectMake(5, 5, 20,20);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;

    audioArtist = [NSArray arrayWithObjects:@"Sabrina Carpenter",@"Lucy Hale",@"Jordon Fisher",@"Olivia Holt",@"Miley Cyrus",@"Martin Luther", nil ];
    audioName = [NSArray arrayWithObjects:@"Footloose:Blue-Ray",@"Footloose:Than & Now",@"Kenny Loggins Talks Footloose",@"Made with the Flaxen Hair.mp3",@"I am super girl",@"All is Well", nil];
    audioImgs = [NSArray arrayWithObjects: @"thirdImage640*250.jpg",@"secImage640*250.jpg",@"thirdImage640*250.jpg",@"firstImg.png",@"secImage640*250.jpg",@"thirdImage640*250.jpg",nil];
    audioViews = [NSArray arrayWithObjects:@"7,111",@"3,102",@"8,475",@"5,407", nil];
    audioTime = [NSArray arrayWithObjects:@"3:33",@"1:56",@"3:04",@"2:00", nil];
    

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
    return [audioImgs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *audioCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"audioCell"];

    audioCell.layoutMargins = UIEdgeInsetsZero;
    audioCell.preservesSuperviewLayoutMargins = false;
    _audioTableView.separatorInset = UIEdgeInsetsZero;

    UIImageView *lblImg = [[UIImageView alloc]init];
    lblImg.frame = CGRectMake(5, 0, self.view.frame.size.width-10, 95);
    lblImg.image = [UIImage imageNamed:[audioImgs objectAtIndex:indexPath.row]];
    //  lblImg.contentMode = UIViewContentModeScaleAspectFit;
    [audioCell.contentView addSubview:lblImg];

    UILabel *albumCat = [UILabel new];
    albumCat.frame = CGRectMake(15, 40, 150, 25);
    [albumCat setTextColor:[UIColor whiteColor]];
    albumCat.font = [UIFont systemFontOfSize:15];
    //[albumCat setBackgroundColor:[UIColor whiteColor]];
    [audioCell.contentView addSubview: albumCat] ;
    albumCat.text = audioArtist[indexPath.row];

    UILabel *lblTrack = [UILabel new];
    lblTrack.frame = CGRectMake(15, 60, 250, 25);
    [lblTrack setTextColor:[UIColor whiteColor]];
    lblTrack.font = [UIFont systemFontOfSize:14];
    //[lblTrack setBackgroundColor:[UIColor whiteColor]];
    [audioCell.contentView addSubview: lblTrack];
    lblTrack.text = audioName[indexPath.row];

    [audioCell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return audioCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PlayingMusic *select = [self.storyboard instantiateViewControllerWithIdentifier:@"selectedSong"];
//
//    select.strImage = audioImgs[indexPath.row];
//    // select.strNavigationTitle = audioName[indexPath.row];
//    select.strSongTotalTime = audioTime[indexPath.row];
//    select.strArtistName = audioArtist[indexPath.row];
//
//    [self.navigationController pushViewController:select animated:NO];
}

@end
