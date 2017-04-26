//
//  LibraryViewController.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/10/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Reachability.h"
#import "SelectedCategory.h"
#define UIColorFromRGB(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController
@synthesize discoverFirst,discoverSecond,discoverThird;

- (void)viewDidLoad
{
    
    [discoverFirst.layer setBorderWidth:1.5f];
    [discoverFirst.layer setBorderColor:[UIColorFromRGB(0X62C9ED) CGColor]];
    [discoverSecond.layer setBorderWidth:1.5f];
    [discoverSecond.layer setBorderColor:[UIColorFromRGB(0X62C9ED) CGColor]];
    [discoverThird.layer setBorderWidth:1.5f];
    [discoverThird.layer setBorderColor:[UIColorFromRGB(0X62C9ED) CGColor]];
    
    [super viewDidLoad];
    
}

-(void)changeButtonBackGroundColor:(UIButton*)sender fontColor:(UIColor*)fontColor backgroundColor:(UIColor*)backgroundColor
{
    NSLog(@"change Btn Color");
    [sender setBackgroundColor: backgroundColor];
    [sender setTitleColor:fontColor forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"discover");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)genresBtn:(id)sender
{
    [self changeButtonBackGroundColor:sender fontColor:UIColorFromRGB(0xFFFFFF) backgroundColor:UIColorFromRGB(0X62C9ED)];
    [self changeButtonBackGroundColor:discoverSecond fontColor:UIColorFromRGB(0X62C9ED) backgroundColor:UIColorFromRGB(0xFFFFFF)];
    [self changeButtonBackGroundColor:discoverThird fontColor:UIColorFromRGB(0X62C9ED) backgroundColor:UIColorFromRGB(0xFFFFFF)];
    GenreViewController *genre = [self.storyboard instantiateViewControllerWithIdentifier:@"pushGenre"];
    
    [self.navigationController pushViewController:genre animated:NO];
}

- (IBAction)musicBtn:(id)sender
{
    [self changeButtonBackGroundColor:sender fontColor:UIColorFromRGB(0xFFFFFF) backgroundColor:UIColorFromRGB(0X62C9ED)];
    [self changeButtonBackGroundColor:discoverFirst fontColor:UIColorFromRGB(0X62C9ED) backgroundColor:UIColorFromRGB(0xFFFFFF)];
    [self changeButtonBackGroundColor:discoverThird fontColor:UIColorFromRGB(0X62C9ED) backgroundColor:UIColorFromRGB(0xFFFFFF)];
    
    PopularMusicController *popular = [self.storyboard instantiateViewControllerWithIdentifier:@"pushPopular"];
    
    [self.navigationController pushViewController:popular animated:NO];
}

- (IBAction)audioBtn:(id)sender
{
    [self changeButtonBackGroundColor:sender fontColor:UIColorFromRGB(0xFFFFFF) backgroundColor:UIColorFromRGB(0X62C9ED)];
    [self changeButtonBackGroundColor:discoverSecond fontColor:UIColorFromRGB(0X62C9ED) backgroundColor:UIColorFromRGB(0xFFFFFF)];
    [self changeButtonBackGroundColor:discoverFirst fontColor:UIColorFromRGB(0X62C9ED) backgroundColor:UIColorFromRGB(0xFFFFFF)];
    
    PopularAudioController *audio =[self.storyboard instantiateViewControllerWithIdentifier:@"pushAudio"];
    
    [self.navigationController pushViewController:audio animated:NO];
}

@end
