//
//  GenreViewController.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 9/11/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "GenreViewController.h"
#import "Reachability.h"
#import "SelectedCategory.h"


@interface GenreViewController ()

@end

@implementation GenreViewController


- (void)viewDidLoad
{
    [self discoverCategory];
    
    self.navigationItem.title = @"GENRE";
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
    
    btnNext1.frame = CGRectMake(5, 5, 20,20);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;

    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if (internetStatus != NotReachable)
    {
         NSLog(@"Valid Internet Connection");
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Network Error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    [self.genresTableView reloadData];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.genresTableView reloadData];
    [super viewWillAppear:animated];
}

-(void)discoverCategory
{
    dataArray = [[NSMutableArray alloc]init];
    
    NSString *post = [NSString stringWithFormat:@"limit_genre=%d",10];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:DiscoverGenreAPI]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if( theConnection )
    {
        NSLog(@"theConnection is  %@",theConnection);
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    discoverData = [[NSMutableData alloc]init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"received data is %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    NSMutableData *dataStr;
    dataStr = [[NSMutableData alloc]initWithData:data];
    [discoverData appendData:dataStr];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id result = [NSJSONSerialization JSONObjectWithData:discoverData options:kNilOptions error:nil];
    NSLog(@"result album is %@",result);
    
    BOOL success = [[result objectForKey:@"success"] boolValue];
    
    NSString *errorAlert = [result objectForKey:@"error"];
    NSLog(@"errorAlert is %@",errorAlert);
    
    NSArray *data = [result valueForKey:@"data"];
    NSLog(@"data is %@",data);
    
    if (success)
    {
        NSLog(@"album songs loaded successfully");
        
        NSDictionary *dataObj;
        
        success = [[result valueForKey:@"success"]boolValue];
        
        dataObj = [result valueForKey:@"data"];
        
        for (NSDictionary *bpdict in data)
        {
            NSLog(@"for loop %@", bpdict);
            
            [dataArray addObject:bpdict];
        }
        NSLog(@"response %lu",(unsigned long)dataArray.count);
        
        [_genresTableView reloadData];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:errorAlert delegate:self cancelButtonTitle:@"Ok"otherButtonTitles: nil];
        [alert show];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
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
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    customCell *Cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Cell.discoverGenreCategoryName.text = [dataArray[indexPath.row] valueForKey:@"name"];
        
    NSString *track = @"Tracks";
    NSString *songsCount = [dataArray[indexPath.row] valueForKey:@"songsCount"];
    NSString *fullText = [NSString stringWithFormat:@"%@ %@", songsCount,track];
    Cell.discoverGenreSongtrack.text = fullText;
    
    Cell.discoverGenreImgView.image = [UIImage imageNamed:@"secImage640*250.jpg"];
    
    Cell.layoutMargins = UIEdgeInsetsZero;
    Cell.preservesSuperviewLayoutMargins = false;
    // Cell.separatorInset = UIEdgeInsetsZero;
    tableView.separatorInset = UIEdgeInsetsZero;
        
    [Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedCategory *selectObj = [self.storyboard instantiateViewControllerWithIdentifier:@"selectMove"];
        
    selectObj.strContainsAlbumID = [dataArray[indexPath.row] valueForKey:@"id"];
    selectObj.strContainsAlbumSong = [dataArray[indexPath.row] valueForKey:@"name"];
    selectObj.topSongs = [dataArray[indexPath.row] valueForKey:@"songs"];
    
    [self.navigationController pushViewController:selectObj animated:NO];
}


@end
