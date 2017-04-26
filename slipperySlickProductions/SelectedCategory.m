//
//  SelectedCategory.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/13/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "SelectedCategory.h" 

BOOL displayImage = NO;
NSURL *url = nil;
NSString *userId = 0;

@interface SelectedCategory ()
{
    BOOL hitWebService;
    int limits;
    id genreID;
    BOOL validUrl;
}
@end

@implementation SelectedCategory
@synthesize CategoryImg,CategorySong,CategoryTime,CategoryArtist,CategoryViews,selectedCategoryTableView;
@synthesize strOfSongArray;
@synthesize topSongs;

- (void)viewDidLoad
{
    // NSMutableArray *strOfSongArray = [[NSMutableArray alloc]init];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = _strContainsAlbumSong;
    
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
    
    btnNext1.frame = CGRectMake(5, 5, 20,20);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;
    
    hitWebService = true;
    limits = 10;
    
    [super viewDidLoad];
    
    strOfSongArray = [[NSMutableArray alloc]init];
    
    for (int i = 0  ; i<topSongs.count; i++)
    {
        [strOfSongArray addObject:topSongs[i]];
    }
    NSLog(@"topSongs is %@",topSongs);
}

-(IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)fetchData:(int)page limit:(int)limit reloadFromStart:(BOOL)reloadFromStart
{
    NSString *post = [NSString stringWithFormat:@"genre_id=%@&count=%d&limit=%d",_strContainsAlbumID,page,limit];
    NSLog(@"post is %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://slipperyy.com/beta/api/pagination"]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"Response is %@",response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSLog(@" data is %@",data);
    
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    
    songsMutableData = [[NSMutableData alloc]initWithData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%lu",(unsigned long)strOfSongArray.count);
    
    id result = [NSJSONSerialization JSONObjectWithData:songsMutableData options:kNilOptions error:nil];
    
    NSLog(@"result is %@",result);
    
    BOOL success = [[result objectForKey:@"success"] boolValue];
    
    NSString *errorAlert = [result objectForKey:@"error"];
    
    NSLog(@"errorAlert is %@",errorAlert);
    
    if (success)
    {
        NSLog(@"success loop");
        
        NSArray *dataObj = [result valueForKey:@"data"];
        
        NSLog(@"data is %@",dataObj);
        
        int j = 0;
        
        for (j = 0; j<dataObj.count; j++)
        {
            //[strOfSongArray addObject:dataObj[j]];
            [strOfSongArray addObject:dataObj[j]];
        }
        
        NSLog(@"dataObj is %lu",(unsigned long)dataObj.count);
        
        NSLog(@"strOfSongArray is %lu",(unsigned long)strOfSongArray.count);
        
        if (dataObj.count < limits)
        {
            hitWebService = false;
        }
        else
        {
            hitWebService = true;
        }
        [selectedCategoryTableView reloadData];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int newScroll = scrollView.contentOffset.y;
    
    int maxScroll = (strOfSongArray.count*63)- selectedCategoryTableView.frame.size.height;
    
    if ((newScroll >= maxScroll) && hitWebService == true)
    {
        hitWebService = false;
        
        [self fetchData:(int)strOfSongArray.count limit:10 reloadFromStart:false];
    }
}

#pragma Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [strOfSongArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    customCell *Cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (Cell == nil)
    {
        Cell = [[customCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Cell.albumSong.text = [strOfSongArray[indexPath.row] valueForKey:@"m_title"];
    
    strNavigationTitle = Cell.albumSong.text;
    
    songImg = [strOfSongArray[indexPath.row] valueForKey:@"m_file_image"];
    
    NSURL *url = [NSURL URLWithString:songImg];
    
    NSLog(@"url is %@",url);
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(concurrentQueue, ^{
        NSData *image = [[NSData alloc] initWithContentsOfURL:url];
                
        dispatch_async(dispatch_get_main_queue(), ^{
                    
            if (image != nil)
            {
                Cell.selectedCategoryImg.image = [UIImage imageWithData:image];
            }
            else
            {
                Cell.selectedCategoryImg.image = [UIImage imageNamed:@"no_image_icon.png"];
            }
        });
    });
    displayImage = YES;
    
    NSLog(@"Cell.selectedCategoryImg.image is %@",Cell.selectedCategoryImg.image);

    Cell.albumSongViews.text = [strOfSongArray[indexPath.row] valueForKey:@"play_count"];
    Cell.albumSongTIme.text = [strOfSongArray[indexPath.row] valueForKey:@"play_duration"];
    strSongTotalTime = Cell.albumSongTIme.text;
    
    userId = [strOfSongArray[indexPath.row] valueForKey:@"user_id"];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setValue:userId forKey:@"useridForUpload"];
    
    NSLog(@"user is %@",user);

    Cell.layoutMargins = UIEdgeInsetsZero;
    Cell.preservesSuperviewLayoutMargins = false;
    tableView.separatorInset = UIEdgeInsetsZero;
    
    [Cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return Cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingMusic *selectedSong = [self.storyboard instantiateViewControllerWithIdentifier:@"selectedSong"];
    NSLog(@"indexPath.row is %ld",(long)indexPath.row);
    currentPlayList = strOfSongArray;
    currentIndex = indexPath.row;
    currentSongId = [strOfSongArray[indexPath.row] valueForKey:@"id"];
    NSLog(@"currentSongId is %@",currentSongId);
    [self.navigationController pushViewController:selectedSong animated:NO];
}

@end
