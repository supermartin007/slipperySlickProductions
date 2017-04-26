//
//  ProfileViewController.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/13/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "ProfileViewController.h"
BOOL isValue = true;

@interface ProfileViewController ()
{
    CGFloat sizeHeight;
    NSString *imagesForPost;
    
}
@end

@implementation ProfileViewController
@synthesize postArtist,postImg,postSong,postTime,postViews,postsTableBiew,highlightView;
@synthesize playlistArtist,playlistImg,playlistSong,playlistTime,playlistViews,playlistTableView;
@synthesize profileSubviewObj;
@synthesize bioView,bioEmail,bioUserNameLbl;
@synthesize timeLineArtist,timeLineImg,timeLineSong,timeLineTableView,timeLineTime,timeLineViews;
@synthesize albumsTableView,albumsArtist,albumsImg,albumsSong,albumsTime,albumsViews;
@synthesize audioTrackArtist,audioTrackImg,audioTrackSong,audioTrackTime,audioTrackViews;


- (void)viewDidLoad
{
    bioView.hidden = YES;
    postsTableBiew.hidden = NO;
    
    isValue = true;
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setTranslucent:NO];
    [profileSubviewObj.layer setBorderWidth:1.0f];
    profileSubviewObj.layer.borderColor = [UIColor grayColor].CGColor;

    sizeHeight = [UIScreen mainScreen].bounds.size.height;
   
    [super viewDidLoad];
    
    playlistImg = [NSArray arrayWithObjects: @"artist5.jpeg",@"fourthImage640x250.jpg",@"artist11.jpeg", nil];
    playlistArtist = [NSArray arrayWithObjects:@"Miley Cyrus",@"Jordan Fisher ",@"Selena Gomez", nil];
    playlistSong = [NSArray arrayWithObjects:@"Footloose:Blue-Ray",@"Kenny Loggins Talks Footloose",@"Made with the Flaxen Hair.mp3", nil];
    playlistViews = [NSArray arrayWithObjects:@"1,456",@"7,123",@"1,098", nil];
    playlistTime = [NSArray arrayWithObjects:@"2:33",@"3:26",@"3:33", nil];
    
    timeLineImg = [NSArray arrayWithObjects: @"fourthImage640x250.jpg",@"artist7.jpeg",@"artist11.jpeg", nil];
    timeLineArtist = [NSArray arrayWithObjects:@"Miley Cyrus",@"Jordan Fisher ",@"Selena Gomez", nil];
    timeLineSong = [NSArray arrayWithObjects:@"Footloose:Blue-Ray",@"Kenny Loggins Talks Footloose",@"Made with the Flaxen Hair.mp3", nil];
    timeLineViews = [NSArray arrayWithObjects:@"1,456",@"7,123",@"1,098", nil];
    timeLineTime = [NSArray arrayWithObjects:@"2:33",@"3:26",@"3:33", nil];
    
    albumsImg = [NSArray arrayWithObjects: @"artist12.jpeg",@"artist11.jpeg",@"artist5.jpeg", nil];
    albumsArtist = [NSArray arrayWithObjects:@"Miley Cyrus",@"Jordan Fisher ",@"Selena Gomez", nil];
    albumsSong = [NSArray arrayWithObjects:@"Footloose:Blue-Ray",@"Kenny Loggins Talks Footloose",@"Made with the Flaxen Hair.mp3", nil];
    albumsViews = [NSArray arrayWithObjects:@"1,456",@"7,123",@"1,098", nil];
    albumsTime = [NSArray arrayWithObjects:@"2:33",@"3:26",@"3:33", nil];
    
    audioTrackImg = [NSArray arrayWithObjects: @"fourthImage640x250.jpg",@"artist11.jpeg",@"artist10.jpg", nil];
    audioTrackArtist = [NSArray arrayWithObjects:@"Miley Cyrus",@"Jordan Fisher ",@"Selena Gomez", nil];
    audioTrackSong = [NSArray arrayWithObjects:@"Footloose:Blue-Ray",@"Kenny Loggins Talks Footloose",@"Made with the Flaxen Hair.mp3", nil];
    audioTrackViews = [NSArray arrayWithObjects:@"1,456",@"7,123",@"1,098", nil];
    audioTrackTime = [NSArray arrayWithObjects:@"2:33",@"3:26",@"3:33", nil];


    //[postsTableBiew reloadData];
    [playlistTableView reloadData];
    [timeLineTableView reloadData];
    [albumsTableView reloadData];
    
    NSLog(@"user_name is %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"usertype"]);
  
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"usertype"]  isEqual:@"facebook"] )
    {
        NSLog(@" profile name is %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"DisplayName"]);
        _proflieName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"DisplayName"];
        _profileUsername.text = @"";
        _profileEmail.text = @"";
        
         bioUserNameLbl.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"DisplayName"];
        
        // searching facebook image in document directory
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent: @"test.png" ];
        UIImage* image = [UIImage imageWithContentsOfFile:path];
        NSLog(@"image is %@",image);
        
        // display facebook image in profile tab
        _profileImage.image = image;
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"usertype"]  isEqual:@"Twitter"])
    {
        _proflieName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_name"];
        _profileUsername.text = @"";
        _profileEmail.text = @"";
        
        bioUserNameLbl.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_name"];
    }
    else
    {
        _proflieName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"fullname"];
        
        _profileUsername.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_name"];
        
        _profileEmail.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
        
        bioUserNameLbl.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"fullname"];
        
        bioEmail.text =  _profileEmail.text;
    }
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appplicationIsActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == timeLineTableView)
    {
        return 1;
    }
    else if (tableView == postsTableBiew)
    {
        return 1;
    }
    else if (tableView == albumsTableView)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == timeLineTableView)
    {
        return [timeLineImg count];

    }
    else if (tableView == postsTableBiew)
    {
        return [audioTrackImg count];
    }
    else if (tableView == albumsTableView)
    {
        return [albumsImg count];
    }
    else
    {
        return [playlistImg count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == timeLineTableView)
    {
        UITableViewCell *timeLineCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"timeLineIdentifier"];
        
        if (timeLineCell == nil)
        {
            timeLineCell = [tableView dequeueReusableCellWithIdentifier:@"timeLineIdentifier" forIndexPath:indexPath];
            NSLog(@"cell found");
        }
        
        timeLineCell.layoutMargins = UIEdgeInsetsZero;
        timeLineCell.preservesSuperviewLayoutMargins = false;
        tableView.separatorInset = UIEdgeInsetsZero;
        
        UILabel *albumTrack = [UILabel new];
        albumTrack.frame = CGRectMake(self.view.frame.size.width-35, 0, 50, 20);
        [albumTrack setTextColor:[UIColor lightGrayColor]];
        albumTrack.font = [UIFont systemFontOfSize:12.0];
        [albumTrack setBackgroundColor:[UIColor whiteColor]];
        [timeLineCell.contentView addSubview: albumTrack];
        albumTrack.text = timeLineTime[indexPath.row];
        
        UIImageView *lblImg = [[UIImageView alloc]init];
        lblImg.frame = CGRectMake(2, 5, 60, 60);
        lblImg.image = [UIImage imageNamed:timeLineImg[indexPath.row]];
        [timeLineCell.contentView addSubview:lblImg];
        
        UILabel *albumArtist = [UILabel new];
        albumArtist.frame = CGRectMake(68, 0, 180, 25);
        [albumArtist setTextColor:[UIColor lightGrayColor]];
        albumArtist.font = [UIFont systemFontOfSize:12.0];
        [albumArtist setBackgroundColor:[UIColor whiteColor]];
        [timeLineCell.contentView addSubview: albumArtist] ;
        albumArtist.text = timeLineArtist[indexPath.row];
        
        UILabel *albumCat = [UILabel new];
        albumCat.frame = CGRectMake(68, 23, 240, 18);
        [albumCat setTextColor:[UIColor blackColor]];
        albumCat.font = [UIFont systemFontOfSize:15.0];
        [albumCat setBackgroundColor:[UIColor whiteColor]];
        [timeLineCell.contentView addSubview: albumCat] ;
        albumCat.text = timeLineSong[indexPath.row];
        
        UIImageView *staticImg = [[UIImageView alloc]init];
        staticImg.frame = CGRectMake(lblImg.frame.size.width+10,lblImg.frame.size.height-9, 13, 13);
        staticImg.image = [UIImage imageNamed:@"playStaticImage.png"];
        [timeLineCell.contentView addSubview:staticImg];
        
        UILabel *albumViews = [UILabel new];
        albumViews.frame = CGRectMake(lblImg.frame.size.width+28, 50, 40, 15);
        [albumViews setTextColor:[UIColor lightGrayColor]];
        albumViews.font = [UIFont systemFontOfSize:12.0];
        [albumViews setBackgroundColor:[UIColor whiteColor]];
        [timeLineCell.contentView addSubview: albumViews];
        albumViews.text = timeLineViews[indexPath.row];
        
         [timeLineCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return timeLineCell;
    }
    else if (tableView == albumsTableView)
    {
        UITableViewCell *albumsCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"albumsIdentifier"];
        
        if (albumsCell == nil)
        {
            albumsCell = [tableView dequeueReusableCellWithIdentifier:@"albumsIdentifier" forIndexPath:indexPath];
            NSLog(@"cell found");
        }
        
        albumsCell.layoutMargins = UIEdgeInsetsZero;
        albumsCell.preservesSuperviewLayoutMargins = false;
        tableView.separatorInset = UIEdgeInsetsZero;
        
        UILabel *albumTrack = [UILabel new];
        albumTrack.frame = CGRectMake(self.view.frame.size.width-35, 0, 50, 20);
        [albumTrack setTextColor:[UIColor lightGrayColor]];
        albumTrack.font = [UIFont systemFontOfSize:12.0];
        [albumTrack setBackgroundColor:[UIColor whiteColor]];
        [albumsCell.contentView addSubview: albumTrack];
        albumTrack.text = albumsTime[indexPath.row];
        
        UIImageView *lblImg = [[UIImageView alloc]init];
        lblImg.frame = CGRectMake(2, 5, 60, 60);
        lblImg.image = [UIImage imageNamed:albumsImg[indexPath.row]];
        [albumsCell.contentView addSubview:lblImg];
        
        UILabel *albumArtist = [UILabel new];
        albumArtist.frame = CGRectMake(68, 0, 180, 25);
        [albumArtist setTextColor:[UIColor lightGrayColor]];
        albumArtist.font = [UIFont systemFontOfSize:12.0];
        [albumArtist setBackgroundColor:[UIColor whiteColor]];
        [albumsCell.contentView addSubview: albumArtist] ;
        albumArtist.text = albumsArtist[indexPath.row];
        
        UILabel *albumCat = [UILabel new];
        albumCat.frame = CGRectMake(68, 23, 240, 18);
        [albumCat setTextColor:[UIColor blackColor]];
        albumCat.font = [UIFont systemFontOfSize:15.0];
        [albumCat setBackgroundColor:[UIColor whiteColor]];
        [albumsCell.contentView addSubview: albumCat] ;
        albumCat.text = albumsSong[indexPath.row];
        
        UIImageView *staticImg = [[UIImageView alloc]init];
        staticImg.frame = CGRectMake(lblImg.frame.size.width+10,lblImg.frame.size.height-9, 13, 13);
        staticImg.image = [UIImage imageNamed:@"playStaticImage.png"];
        [albumsCell.contentView addSubview:staticImg];
        
        UILabel *albumViews = [UILabel new];
        albumViews.frame = CGRectMake(lblImg.frame.size.width+28, 50, 40, 15);
        [albumViews setTextColor:[UIColor lightGrayColor]];
        albumViews.font = [UIFont systemFontOfSize:12.0];
        [albumViews setBackgroundColor:[UIColor whiteColor]];
        [albumsCell.contentView addSubview: albumViews];
        albumViews.text = albumsViews[indexPath.row];
        
        [albumsCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        
        return albumsCell;
    }
    else if (tableView == postsTableBiew)
    {
        UITableViewCell *audioTrackCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"audioTrackIdentifier"];
        
        if (audioTrackCell == nil)
        {
            audioTrackCell = [tableView dequeueReusableCellWithIdentifier:@"audioTrackIdentifier" forIndexPath:indexPath];
            NSLog(@"cell found");
        }
        
        audioTrackCell.layoutMargins = UIEdgeInsetsZero;
        audioTrackCell.preservesSuperviewLayoutMargins = false;
        tableView.separatorInset = UIEdgeInsetsZero;
        
        UILabel *albumTrack = [UILabel new];
        albumTrack.frame = CGRectMake(self.view.frame.size.width-35, 0, 50, 20);
        [albumTrack setTextColor:[UIColor lightGrayColor]];
        albumTrack.font = [UIFont systemFontOfSize:12.0];
        [albumTrack setBackgroundColor:[UIColor whiteColor]];
        [audioTrackCell.contentView addSubview: albumTrack];
        albumTrack.text = audioTrackTime[indexPath.row];
        
        UIImageView *lblImg = [[UIImageView alloc]init];
        lblImg.frame = CGRectMake(2, 5, 60, 60);
        lblImg.image = [UIImage imageNamed:audioTrackImg[indexPath.row]];
        [audioTrackCell.contentView addSubview:lblImg];
        
        UILabel *albumArtist = [UILabel new];
        albumArtist.frame = CGRectMake(68, 0, 180, 25);
        [albumArtist setTextColor:[UIColor lightGrayColor]];
        albumArtist.font = [UIFont systemFontOfSize:12.0];
        [albumArtist setBackgroundColor:[UIColor whiteColor]];
        [audioTrackCell.contentView addSubview: albumArtist] ;
        albumArtist.text = audioTrackArtist[indexPath.row];
        
        UILabel *albumCat = [UILabel new];
        albumCat.frame = CGRectMake(68, 23, 240, 18);
        [albumCat setTextColor:[UIColor blackColor]];
        albumCat.font = [UIFont systemFontOfSize:15.0];
        [albumCat setBackgroundColor:[UIColor whiteColor]];
        [audioTrackCell.contentView addSubview: albumCat] ;
        albumCat.text = audioTrackSong[indexPath.row];
        
        UIImageView *staticImg = [[UIImageView alloc]init];
        staticImg.frame = CGRectMake(lblImg.frame.size.width+10,lblImg.frame.size.height-9, 13, 13);
        staticImg.image = [UIImage imageNamed:@"playStaticImage.png"];
        [audioTrackCell.contentView addSubview:staticImg];
        
        UILabel *albumViews = [UILabel new];
        albumViews.frame = CGRectMake(lblImg.frame.size.width+28, 50, 40, 15);
        [albumViews setTextColor:[UIColor lightGrayColor]];
        albumViews.font = [UIFont systemFontOfSize:12.0];
        [albumViews setBackgroundColor:[UIColor whiteColor]];
        [audioTrackCell.contentView addSubview: albumViews];
        albumViews.text = audioTrackViews[indexPath.row];
        
         [audioTrackCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return audioTrackCell;
    }
    else
    {
        UITableViewCell *playlistCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"playlistIdentifier"];
        
        if (playlistCell == nil)
        {
            playlistCell = [tableView dequeueReusableCellWithIdentifier:@"playlistIdentifier" forIndexPath:indexPath];
            NSLog(@"cell found");
        }
        
        playlistCell.layoutMargins = UIEdgeInsetsZero;
        playlistCell.preservesSuperviewLayoutMargins = false;
        tableView.separatorInset = UIEdgeInsetsZero;
        
        UILabel *albumTrack = [UILabel new];
        albumTrack.frame = CGRectMake(self.view.frame.size.width-35, 0, 50, 20);
        [albumTrack setTextColor:[UIColor lightGrayColor]];
        albumTrack.font = [UIFont systemFontOfSize:12.0];
        [albumTrack setBackgroundColor:[UIColor whiteColor]];
        [playlistCell.contentView addSubview: albumTrack];
        albumTrack.text = playlistTime[indexPath.row];
        
        UIImageView *lblImg = [[UIImageView alloc]init];
        lblImg.frame = CGRectMake(2, 5, 60, 60);
        lblImg.image = [UIImage imageNamed:playlistImg[indexPath.row]];
        [playlistCell.contentView addSubview:lblImg];
        
        UILabel *albumArtist = [UILabel new];
        albumArtist.frame = CGRectMake(68, 0, 180, 25);
        [albumArtist setTextColor:[UIColor lightGrayColor]];
        albumArtist.font = [UIFont systemFontOfSize:12.0];
        [albumArtist setBackgroundColor:[UIColor whiteColor]];
        [playlistCell.contentView addSubview: albumArtist] ;
        albumArtist.text = playlistArtist[indexPath.row];
        
        UILabel *albumCat = [UILabel new];
        albumCat.frame = CGRectMake(68, 23, 240, 18);
        [albumCat setTextColor:[UIColor blackColor]];
        albumCat.font = [UIFont systemFontOfSize:15.0];
        [albumCat setBackgroundColor:[UIColor whiteColor]];
        [playlistCell.contentView addSubview: albumCat] ;
        albumCat.text = playlistSong[indexPath.row];
        
        UIImageView *staticImg = [[UIImageView alloc]init];
        staticImg.frame = CGRectMake(lblImg.frame.size.width+10,lblImg.frame.size.height-9, 13, 13);
        staticImg.image = [UIImage imageNamed:@"playStaticImage.png"];
        [playlistCell.contentView addSubview:staticImg];
        
        UILabel *albumViews = [UILabel new];
        albumViews.frame = CGRectMake(lblImg.frame.size.width+28, 50, 40, 15);
        [albumViews setTextColor:[UIColor lightGrayColor]];
        albumViews.font = [UIFont systemFontOfSize:12.0];
        [albumViews setBackgroundColor:[UIColor whiteColor]];
        [playlistCell.contentView addSubview: albumViews];
        albumViews.text = playlistViews[indexPath.row];
        
          [playlistCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return playlistCell;
    }
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    PlayingMusic *select = [self.storyboard instantiateViewControllerWithIdentifier:@"selectedSong"];
//    
//    if(tableView == postsTableBiew)
//    {
//        select.strImage = postImg[indexPath.row];
//        //select.strNavigationTitle = postSong[indexPath.row];
//        select.strSongTotalTime = postTime[indexPath.row];
//        select.strArtistName = postArtist[indexPath.row];
//    }
//    else
//    {
//        select.strImage = playlistImg[indexPath.row];
//       // select.strNavigationTitle = playlistSong[indexPath.row];
//        select.strSongTotalTime = playlistTime[indexPath.row];
//        select.strArtistName = playlistArtist[indexPath.row];
//    }
//    [self.navigationController pushViewController:select animated:NO];
//}

- (IBAction)postsBtn:(UIButton *)sender
{
    bioView.hidden = YES;
    postsTableBiew.hidden = NO;
    playlistTableView.hidden = YES;
    albumsTableView.hidden = YES;
    timeLineTableView.hidden = YES;
    
    if (sizeHeight == 480)
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-6, sender.frame.size.width, highlightView.frame.size.height);
    }
    
    else if(sizeHeight == 568)
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-7, sender.frame.size.width, highlightView.frame.size.height);
    }
    else
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-9, sender.frame.size.width, highlightView.frame.size.height);
    }
}

- (IBAction)playlistsBtn:(UIButton *)sender
{
    bioView.hidden = YES;
    postsTableBiew.hidden = YES;
    playlistTableView.hidden = NO;
    albumsTableView.hidden = YES;
    postsTableBiew.hidden = YES;
    
    if (sizeHeight == 480)
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-6, sender.frame.size.width, highlightView.frame.size.height);
    }
    else if(sizeHeight == 568)
    {
    highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-7, sender.frame.size.width, highlightView.frame.size.height);
    }
    else
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-9, sender.frame.size.width, highlightView.frame.size.height);
    }
}

- (IBAction)albumsBtn:(UIButton *)sender
{
    bioView.hidden = YES;
    postsTableBiew.hidden = YES;
    playlistTableView.hidden = YES;
    timeLineTableView.hidden = YES;
    albumsTableView.hidden = NO;
    
    if (sizeHeight == 480)
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-6, sender.frame.size.width, highlightView.frame.size.height);
    }
    
    else if(sizeHeight == 568)
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-7, sender.frame.size.width, highlightView.frame.size.height);
    }
    else
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-9, sender.frame.size.width, highlightView.frame.size.height);
    }

    
}

- (IBAction)bioBtn:(UIButton *)sender
{
    bioView.hidden = NO;
    postsTableBiew.hidden = YES;
    playlistTableView.hidden = YES;
    albumsTableView.hidden = YES;
    timeLineTableView.hidden = YES;
    
    
    
    if (sizeHeight == 480)
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-6, sender.frame.size.width, highlightView.frame.size.height);
    }
    
    else if(sizeHeight == 568)
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-7, sender.frame.size.width, highlightView.frame.size.height);
    }
    else
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-9, sender.frame.size.width, highlightView.frame.size.height);
    }

    
}

- (IBAction)infoBtn:(UIButton *)sender
{
    postsTableBiew.hidden = YES;
    playlistTableView.hidden = YES;
    bioView.hidden = YES;
    timeLineTableView.hidden = NO;
    albumsTableView.hidden = YES;
    
    if (sizeHeight == 480)
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-6, sender.frame.size.width, highlightView.frame.size.height);
        
    }
    else if(sizeHeight == 568)
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-7, sender.frame.size.width, highlightView.frame.size.height);
    }
    else
    {
        highlightView.frame = CGRectMake(sender.frame.origin.x,profileSubviewObj.frame.size.height-9, sender.frame.size.width, highlightView.frame.size.height);
    }
}

@end
