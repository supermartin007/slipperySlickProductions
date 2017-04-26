//
//  PlayingMusic.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/13/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "PlayingMusic.h"

AVAudioPlayer *objAudio = nil;
NSString *currentURL = nil;
NSUInteger currentIndex = 0;
NSMutableArray *currentPlayList = nil;
NSString *repeatMode = @"all";
NSString *strNavigationTitle = nil;
NSString *songImg = nil;
NSString *strSongTotalTime = nil;
int noOfUnPlayableSongs = 0;
BOOL allowPlay = YES;
int isFirstTimeNone = 0;
NSData *soundData = nil;
NSString *currentSongId = nil;

@interface PlayingMusic ()
{
    int i;
    int isFirstTime;
    BOOL isVisible;
    NSData *image;
    BOOL trimmingMode;
    AVAudioPlayer *newObjAudio;
    MBProgressHUD *HUD;
    NSURL *audioFileOutput;
    NSString *requiredOutputPath;
    NSString *songId;
    NSString *pathForInstagram;
    CGSize sizeD;
    BOOL isMoved;
    AVAsset *asset;
    NSString *filePathForCroppingAudio;
    int startTime;
    int stopStart;
}

@end

@implementation PlayingMusic
@synthesize strImage,imageViewOutlet,songLbl,songTotalTimeLbl,artistLbl,strArtistName;
@synthesize outletOfPauseBtn,outletOfPlayBtn;
@synthesize positionSlider,timeIncrease;
@synthesize tempSounds,outletOfRepeatBtn,slider;
@synthesize outetOfTrimBtn,outletOfCancelBtn,outletOfSelectAudioBtn;
@synthesize outletOfFarwordBtn,outletOfPreviousBtn;
@synthesize loader,loaderView,outletOfDeSelectAudioBtn;
@synthesize popUpView,blurView;


- (void)viewDidLoad
{
    blurView.hidden = YES;
    
    self.outletOfCancelFromPopUp.layer.borderWidth = 1.5f;
    self.outletOfCancelFromPopUp.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.likeLbl.layer.borderWidth = 1.5f;
    self.likeLbl.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.repostLbl.layer.borderWidth = 1.5f;
    self.repostLbl.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.commentLbl.layer.borderWidth = 1.5f;
    self.commentLbl.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.shareLbl.layer.borderWidth = 1.5f;
    self.shareLbl.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.outletOfInstagram.layer.borderWidth = 1.5f;
    self.outletOfInstagram.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    popUpView.hidden = YES;
    
    self.outletOfInstagram.hidden = NO;
    self.outletOfInstagram.enabled = NO;
    
    self.outletOfMenuBtn.hidden = NO;
    self.outletOfMenuBtn.enabled = YES;
    
//    self.outletOfMenuBtn.hidden = NO;
//    self.outletOfMenuBtn.enabled = NO;
    
    slider.minValue = 25.0f;
    slider.maxValue = 60.0f;
    
    self.leftLbl.hidden = YES;
    self.rightLbl.hidden = YES;
    
    isMoved = YES;
    
    loaderView.layer.cornerRadius = 5;
    loaderView.layer.masksToBounds = YES;
    
    songId = currentSongId;
    NSLog(@"songId is %@",songId);
    loaderView.hidden = NO;
    loader.hidden = NO;
    _wrapperView.hidden = NO;
    
    loader.frame = CGRectMake((loaderView.frame.size.width/2)-(loader.frame.size.width/2), (loaderView.frame.size.height/2)-(loader.frame.size.height/2),loader.frame.size.width, loader.frame.size.height);
    
    timeIncrease.text = @"-:--";
    songTotalTimeLbl.text = @"-:--";
    outetOfTrimBtn.hidden = false;
    outletOfCancelBtn.hidden = true;
    outletOfDeSelectAudioBtn.hidden = YES;
    trimmingMode = NO;
    outletOfSelectAudioBtn.hidden = YES;
    _outletOfSliderCover.hidden = YES;
    
    isVisible = NO;
    slider.hidden = YES;
    positionSlider.hidden = NO;
    //coverView.hidden = NO;
    
    songImg = [[NSString alloc]init];
    isFirstTime = 0;
    isFirstTimeNone = 0;
    noOfUnPlayableSongs = 0;
    
    if ([repeatMode isEqualToString:@"all"])
    {
        [outletOfRepeatBtn setImage:[UIImage imageNamed:@"repeat-b1.png"] forState:UIControlStateNormal];
    }
    
    if ([repeatMode isEqualToString:@"one"])
    {
        [outletOfRepeatBtn setImage:[UIImage imageNamed:@"repeat-b2.png"] forState:UIControlStateNormal];
    }
    
    if ([repeatMode isEqualToString:@"none"])
    {
        [outletOfRepeatBtn setImage:[UIImage imageNamed:@"repeat-b.png"] forState:UIControlStateNormal];
    }
    
    self.navigationItem.hidesBackButton = YES;
    
    outletOfPreviousBtn.layer.cornerRadius = outletOfPreviousBtn.frame.size.width/2;
    outletOfFarwordBtn.layer.cornerRadius = outletOfFarwordBtn.frame.size.width/2;
    outletOfPauseBtn.layer.cornerRadius = outletOfPauseBtn.frame.size.width/2;
    outletOfPlayBtn.layer.cornerRadius = outletOfPlayBtn.frame.size.width/2;
    
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    
    btnNext1.frame = CGRectMake(5, 5, 20, 20);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;
    
    [super viewDidLoad];

    self.navigationItem.title = strNavigationTitle;
    songLbl.text = strNavigationTitle;
    //songTotalTimeLbl.text = ;
    artistLbl.text = strArtistName;
    
    outletOfPauseBtn.hidden = NO;
    outletOfPlayBtn.hidden = YES;
    
    [self audioPlayerDidFinishPlaying:objAudio successfully:YES];
    soundData = Nil;
    [objAudio stop];
    NSLog(@"soundData is %@",soundData);
    
//    UIImage *movieImg = [UIImage imageNamed:@"artist5.jpeg"];
}

-(void)playSound
{
    NSLog(@"currentPlayList is %lu",(unsigned long)currentIndex);
    
    NSURL *url = [NSURL URLWithString:[currentPlayList[currentIndex] valueForKey:@"audio_url"]];
    
    NSLog(@"url is %@",url);
    
    timeIncrease.hidden = NO;
    
    songTotalTimeLbl.hidden = NO;
    
    loaderView.hidden = NO;
    
    loader.hidden = NO;
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
     [loader startAnimating];
    
    dispatch_async(concurrentQueue, ^{
         
        soundData = [[NSData alloc] initWithContentsOfURL:url];
        
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)objectAtIndex:0];
        
        filePathForCroppingAudio = [documents stringByAppendingPathComponent:@"abc.mp3"];
        
        [soundData writeToFile:filePathForCroppingAudio atomically:YES];
        
        NSLog(@"filePathForCroppingAudio is %@",filePathForCroppingAudio);

        NSError*errors;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [loader stopAnimating];
            
            loaderView.hidden = YES;
            
            loader.hidden = YES;
            
            _wrapperView.hidden = YES;
                 
            if (songId == currentSongId)
            {
                if (soundData == nil)
                {
                    if (noOfUnPlayableSongs >= currentPlayList.count)
                    {
                        [self.navigationController popViewControllerAnimated:NO];
                    }
                    else
                    {
                        NSLog(@"soundData did not load properly: %@", [errors description]);
                             
                        noOfUnPlayableSongs++;
                             
                        if (isFirstTime > 0)
                        {
                            if (currentIndex == currentPlayList.count-1)
                            {
                                currentIndex = 0;
                            }
                            else
                            {
                                currentIndex++;
                            }
                        }
                        isFirstTime++;
                        [self playSound];
                    }
                }
                else
                {
                    NSError *error;
                         
                    NSLog(@"worked");
                         
                    objAudio = [[AVAudioPlayer alloc] initWithData:soundData fileTypeHint:AVFileTypeMPEGLayer3 error:&error];
                         
                    if (objAudio == nil)
                    {
                        NSLog(@"AudioPlayer did not load properly: %@",[error description]);
                             
                        if (isFirstTime > 0)
                        {
                            if (currentIndex == currentPlayList.count-1)
                            {
                                currentIndex = 0;
                            }
                            else
                            {
                                currentIndex++;
                            }
                        }
                        isFirstTime++;
                        [self playSound];
                    }
                    else
                    {
                        [objAudio play];
                    }
                    isPlayingNextSong = YES;
                         
                    objAudio.delegate = self;
                    
                    objAudio.volume = 1.0;
                         
                    objAudio.numberOfLoops = 0;
                         
                    [objAudio prepareToPlay];
                         
                    positionSlider.maximumValue = objAudio.duration;
                         
                    NSLog(@"objAudio.duration is %f",objAudio.duration);
                         
                    double currentTime = objAudio.duration;
                    int minutes = floor(currentTime/60);
                    int seconds = trunc(currentTime - minutes * 60);
                    if (seconds<10)
                    {
                        NSString *currentTimeString = [NSString stringWithFormat:@"%i:0%i" ,minutes,seconds];
                        NSLog(@"currentTimeString is %@",currentTimeString);
                        songTotalTimeLbl.text =  currentTimeString;
                    }
                    else
                    {
                        NSString *currentTimeString = [NSString stringWithFormat:@"%i:%i" ,minutes,seconds];
                        NSLog(@"currentTimeString is %@",currentTimeString);
                        songTotalTimeLbl.text =  currentTimeString;
                    }
                    positionSlider.minimumValue = 0.0f;
                    objAudio.currentTime = positionSlider.value;
                         
                    [objAudio play];
                         
                    [self updateDisplay];
                         
                    if (!(soundTimer = nil))
                    {
                        soundTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
                        NSLog(@"soundTimer condition working");
                    }
                    objAudio.currentTime = positionSlider.minimumValue;
                    positionSlider.hidden = NO;
                         
                    NSLog(@" positionSlider.value is %f", objAudio.currentTime);
                }
            }
        });
    });
}

- (IBAction)trimBtn:(id)sender
{
    
    positionSlider.hidden = YES;

    self.outletOfInstagram.hidden = NO;
    self.outletOfInstagram.enabled = NO;
    
    slider.minValue = 0.0f;
    slider.maxValue = 85.0f;

    slider.hidden = NO;
    slider.enabled = YES;

    self.leftLbl.hidden = NO;
    self.rightLbl.hidden = NO;
    timeIncrease.hidden = YES;
    songTotalTimeLbl.hidden = YES;
    
    timeIncrease.hidden = YES;
    songTotalTimeLbl.hidden = YES;
    outletOfPlayBtn.hidden = NO;
    
    trimmingMode = YES;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectorys = [paths objectAtIndex:0];
    
    NSLog(@"documentDirectory is %@",documentDirectorys);
    
    NSURL *audioFileInput = [NSURL fileURLWithPath:filePathForCroppingAudio];
    
    requiredOutputPath = [documentDirectorys stringByAppendingPathComponent:@"output.m4a"];
    
    audioFileOutput = [NSURL fileURLWithPath:requiredOutputPath];
    
    if (!audioFileInput || !audioFileOutput)
    {
                NSLog(@"return NO");
    }
    
    [[NSFileManager defaultManager] removeItemAtURL:audioFileOutput error:NULL];
    asset = [AVAsset assetWithURL:audioFileInput];
        
    NSLog(@"asset is %@",audioFileOutput);
    
    if (isVisible == NO)
    {
        if (trimmingMode == YES)
        {
            slider.hidden = NO;
            slider.enabled = YES;
            positionSlider.hidden = YES;
            _outletOfSliderCover.hidden = YES;
            self.outletOfInstagram.hidden = NO;
            self.outletOfInstagram.enabled = NO;
            outletOfPlayBtn.hidden = NO;
            outletOfPlayBtn.enabled = YES;
    
            [slider setDisplayMode:BJRSWPAudioSetTrimMode];
    
            [slider addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
        }
        else
        {
            NSLog(@"Trimming Mode else");
        }
    }
    else
    {
        NSLog(@"Not Visible");
    }

    
    outletOfPauseBtn.hidden = YES;
    outletOfRepeatBtn.enabled = NO;
    outletOfPreviousBtn.enabled = NO;
    outletOfFarwordBtn.enabled = NO;
    outletOfDeSelectAudioBtn.hidden = YES;
    outletOfSelectAudioBtn.hidden = NO;
    [objAudio pause];
    outetOfTrimBtn.hidden = YES;
    outletOfCancelBtn.hidden = NO;
}

-(void)Crop
{
    positionSlider.hidden = YES;
    
    self.outletOfInstagram.hidden = NO;
    self.outletOfInstagram.enabled = NO;
    
   // self.outletOfMenuBtn.hidden = NO;
   // self.outletOfMenuBtn.enabled = NO;
    
    slider.hidden = NO;
    slider.enabled = YES;
    
    self.leftLbl.hidden = NO;
    self.rightLbl.hidden = NO;
    timeIncrease.hidden = YES;
    songTotalTimeLbl.hidden = YES;
    
    timeIncrease.hidden = YES;
    songTotalTimeLbl.hidden = YES;
    outletOfPlayBtn.hidden = NO;
    
    trimmingMode = YES;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectorys = [paths objectAtIndex:0];
    
    NSLog(@"documentDirectory is %@",documentDirectorys);
    
    NSURL *audioFileInput = [NSURL fileURLWithPath:filePathForCroppingAudio];
    
    requiredOutputPath = [documentDirectorys stringByAppendingPathComponent:@"output.m4a"];
    
    audioFileOutput = [NSURL fileURLWithPath:requiredOutputPath];
    
    if (!audioFileInput || !audioFileOutput)
    {
        NSLog(@"return NO");
    }
    
    [[NSFileManager defaultManager] removeItemAtURL:audioFileOutput error:NULL];
    asset = [AVAsset assetWithURL:audioFileInput];
    
    NSLog(@"asset is %@",audioFileOutput);
    
    if (isVisible == NO)
    {
        if (trimmingMode == YES)
        {
            slider.hidden = NO;
            slider.enabled = YES;
            positionSlider.hidden = YES;
            _outletOfSliderCover.hidden = YES;
            self.outletOfInstagram.hidden = NO;
            self.outletOfInstagram.enabled = NO;
            
           // self.outletOfMenuBtn.hidden = NO;
           // self.outletOfMenuBtn.enabled = NO;
            
            
            outletOfPlayBtn.hidden = NO;
            outletOfPlayBtn.enabled = YES;
            
            [slider setDisplayMode:BJRSWPAudioSetTrimMode];
            
            [slider addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
        }
        else
        {
            NSLog(@"Trimming Mode else");
        }
    }
    else
    {
        NSLog(@"Not Visible");
    }
    
    outletOfPauseBtn.hidden = YES;
    outletOfRepeatBtn.enabled = NO;
    outletOfPreviousBtn.enabled = NO;
    outletOfFarwordBtn.enabled = NO;
    outletOfDeSelectAudioBtn.hidden = YES;
    outletOfSelectAudioBtn.hidden = NO;
    [objAudio pause];
    outetOfTrimBtn.hidden = YES;
    outletOfCancelBtn.hidden = NO;

}

-(void)updateSlider
{
    [positionSlider setValue:objAudio.currentTime];
    [self updateDisplay];
}

- (void)setCurrentAudioTime:(float)value
{
    [objAudio setCurrentTime:value];
}

#pragma mark - Display Update

- (void)updateDisplay
{
    double currentTime = objAudio.currentTime;
    int minutes = floor(currentTime/60);
    int seconds = trunc(currentTime - minutes * 60);
    
    if (seconds < 10)
    {
         timeIncrease.text = [NSString stringWithFormat:@"%i:0%i" ,minutes,seconds];
    }
    else
    {
        timeIncrease.text = [NSString stringWithFormat:@"%i:%i" ,minutes,seconds];
    }
}

- (void)updateSliderLabels
{
    NSTimeInterval currentTime = slider.rightValue;
    double time = currentTime;
    
    int minutes = floor(time/60);
    int seconds = trunc(time - minutes * 60);
    
    if (seconds < 10)
    {
        self.rightLbl.text = [NSString stringWithFormat:@"%i:0%i" ,minutes,seconds];
    }
    else
    {
        self.rightLbl.text = [NSString stringWithFormat:@"%i:%i" ,minutes,seconds];
    }
}

-(IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)sliderValueChange
{
    [objAudio setCurrentTime:positionSlider.value];
    [self updateDisplay];
    
    objAudio.currentTime = positionSlider.value;
    [objAudio prepareToPlay];
    //[self btnPlay:self];
}

- (IBAction)btnPlay:(id)sender
{
    outletOfPlayBtn.hidden = YES;
    outletOfPauseBtn.hidden = NO;
    
    if (trimmingMode == NO)
    {
        slider.hidden = YES;
        positionSlider.hidden = NO;
        timeIncrease.hidden = NO;
        songTotalTimeLbl.hidden = NO;
        
        if (![objAudio isPlaying])
        {
            [objAudio play];
        }
        else
        {
            [objAudio pause];
        }
        [self updateDisplay];
    }
    else if (trimmingMode == YES)
    {
        isPlayClicked = YES;
        
        NSLog(@"slider.rightValue - slider.leftValue is %f",slider.rightValue - slider.leftValue);
        
        [self trimAudio:slider.leftValue vocalEndMarker:slider.rightValue songURL:filePathForCroppingAudio playCroppedSong:YES];
        
        int minutes = floor(slider.rightValue/60);
        int seconds = trunc(slider.rightValue - minutes * 60);
        if (seconds<10)
        {
            NSString *currentTimeString = [NSString stringWithFormat:@"%i:0%i" ,minutes,seconds];
            NSLog(@"currentTimeString is %@",currentTimeString);
            self.rightLbl.text =  currentTimeString;
        }
        else
        {
            NSString *currentTimeString = [NSString stringWithFormat:@"%i:%i" ,minutes,seconds];
            NSLog(@"currentTimeString is %@",currentTimeString);
            self.rightLbl.text =  currentTimeString;
        }
        
        slider.hidden = NO;
        positionSlider.hidden = YES;
        [self.slider setDisplayMode:BJRSWPAudioSetTrimMode];

    }
}

- (IBAction)btnPause:(id)sender
{
    outletOfPlayBtn.hidden = false;
    outletOfPauseBtn.hidden = true;
    
    if (trimmingMode == NO)
    {
        if ([objAudio isPlaying])
        {
            [objAudio pause];
            [self updateDisplay];
        }
        else
        {
            [objAudio pause];
        }
    }
    else if (trimmingMode == YES)
    {
        if (![newObjAudio isPlaying])
        {
            [newObjAudio pause];
//            outletOfPlayBtn.hidden = NO;
//            outletOfPlayBtn.enabled = NO;
        }
        else
        {
            [newObjAudio pause];
//            outletOfPlayBtn.hidden = NO;
//            outletOfPlayBtn.enabled = NO;
        }
    }
}

- (IBAction)btnRepeat:(id)sender
{
    isFirstTimeNone = 0;
    if ([repeatMode isEqualToString:@"all"])
    {
        repeatMode = @"one";
        [outletOfRepeatBtn setImage:[UIImage imageNamed:@"repeat-b2.png"] forState:UIControlStateNormal];
    }
    else if ([repeatMode isEqualToString:@"one"])
    {
        repeatMode = @"none";
        [outletOfRepeatBtn setImage:[UIImage imageNamed:@"repeat-b.png"] forState:UIControlStateNormal];
    }
    else if ([repeatMode isEqualToString:@"none"])
    {
        repeatMode = @"all";
        [outletOfRepeatBtn setImage:[UIImage imageNamed:@"repeat-b1.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)btnNextSong:(id)sender
{
    timeIncrease.text = @"-:--";
    songTotalTimeLbl.text = @"-:--";
    [objAudio stop];
    
    if (isFirstTime > 0)
    {
        //positionSlider.hidden = NO;
        if (currentIndex == currentPlayList.count-1)
        {
            currentIndex = 0;
        }
        else
        {
            currentIndex++;
        }
    }
    isFirstTime++;
    outletOfPlayBtn.hidden = YES;
    outletOfPauseBtn.hidden = NO;
    [self playSound];
}

- (IBAction)btnPreviousSong:(id)sender
{
    [objAudio stop];
    timeIncrease.text = @"-:--";
    songTotalTimeLbl.text = @"-:--";

    if (isFirstTime > 0)
    {
        if (currentIndex == 0)
        {
            currentIndex = currentPlayList.count-1;
        }
        else
        {
            currentIndex--;
        }
    }
    isFirstTime++;
    outletOfPlayBtn.hidden = YES;
    outletOfPauseBtn.hidden = NO;
    [self playSound];
}

- (IBAction)btnIncVolume:(id)sender
{
    objAudio.volume = objAudio.volume + 0.15;
  
    NSLog(@"btn volume Increase Clicked %f",objAudio.volume);
}

- (IBAction)btnDecVolume:(id)sender
{
    objAudio.volume = objAudio.volume - 0.15;
    
    NSLog(@"objAudio.volume for dec Volume is %f",objAudio.volume);
}

- (IBAction)shareBtnForInstagram:(id)sender
{
    //self.outletOfMenuBtn.hidden = NO;
   // self.outletOfMenuBtn.enabled = YES;
    
    NSLog(@"slider.rightValue - slider.leftValue %f",slider.rightValue - slider.leftValue);
    
    if (slider.rightValue - slider.leftValue > 15.0f)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Audio must not be longer than 15 seconds" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];

    }
    else
    {
        slider.hidden = NO;
        positionSlider.hidden = YES;
        slider.enabled = NO;
        if (isVisible == NO)
        {
            NSLog(@"%f %f", slider.leftValue, slider.rightValue);
        }
        
        NSError *error = nil;

        // set up file manager, and file videoOutputPath, remove "test_output.mp4" if it exists...
        //NSString *videoOutputPath = @"/Users/someuser/Desktop/test_output.mp4";
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *documentsDirectory = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
        NSString *videoOutputPath = [documentsDirectory stringByAppendingPathComponent:@"test_output.mp4"];
    
        //NSLog(@"-->videoOutputPath= %@", videoOutputPath);
        // get rid of existing mp4 if exists...
    
        if ([fileMgr removeItemAtPath:videoOutputPath error:&error] != YES)
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    
        CGSize imageSize = CGSizeMake(400,200);
        NSUInteger fps = slider.rightValue - slider.leftValue;
        
        NSLog(@"fps is %lu",(unsigned long)fps);
    
        //NSMutableArray *imageArray;
        //imageArray = [[NSMutableArray alloc] initWithObjects:@"download.jpeg", @"download2.jpeg", nil];
    
        NSMutableArray *imageArray;
    
        NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"icon-600X300.png"];
    
        NSLog(@"str is %@",str);
        
        NSArray *imagePaths = [NSArray arrayWithObjects:str,str,str,nil];
        
        imageArray = [[NSMutableArray alloc] initWithCapacity:imagePaths.count];
    
        NSLog(@"-->imageArray.count= %lu",(unsigned long)imageArray.count);
    
        for (NSString* path in imagePaths)
        {
            [imageArray addObject:[UIImage imageWithContentsOfFile:path]];
        //NSLog(@"-->image path= %@", path);
        }
    
    //////////////     end setup    ///////////////////////////////////
    
        NSLog(@"Start building video from defined frames.");
    
        AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:videoOutputPath] fileType:AVFileTypeQuickTimeMovie error:&error];
        NSParameterAssert(videoWriter);
    
        NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey,[NSNumber numberWithInt:imageSize.width], AVVideoWidthKey,[NSNumber numberWithInt:imageSize.height], AVVideoHeightKey,nil];
    
        AVAssetWriterInput* videoWriterInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    
    
        AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:videoWriterInput sourcePixelBufferAttributes:nil];
        
        NSParameterAssert(videoWriterInput);
        NSParameterAssert([videoWriter canAddInput:videoWriterInput]);
        videoWriterInput.expectsMediaDataInRealTime = YES;
        [videoWriter addInput:videoWriterInput];
    
        //Start a session:
        [videoWriter startWriting];
        [videoWriter startSessionAtSourceTime:kCMTimeZero];
    
        CVPixelBufferRef buffer = NULL;
    
        //convert uiimage to CGImage.
        int frameCount = 0;
        double numberOfSecondsPerFrame = fps/3;
        double frameDuration = fps *numberOfSecondsPerFrame;
    
        //for(VideoFrame * frm in imageArray)
        NSLog(@"**************************************************");
        for(UIImage * img in imageArray)
        {
        //UIImage * img = frm._imageFrame;
        buffer = [self pixelBufferFromCGImage:[img CGImage]];
        
        BOOL append_ok = NO;
        int j = 0;
        while (!append_ok && j < fps)
        {
            if (adaptor.assetWriterInput.readyForMoreMediaData)
            {
                //print out status:
                NSLog(@"Processing video frame (%d,%lu)",frameCount,(unsigned long)[imageArray count]);
                
                CMTime frameTime = CMTimeMake(frameCount*frameDuration,(int32_t) fps);
                append_ok = [adaptor appendPixelBuffer:buffer withPresentationTime:frameTime];
                if(!append_ok)
                {
                    NSError *error = videoWriter.error;
                    if(error!=nil)
                    {
                        NSLog(@"Unresolved error %@,%@.", error, [error userInfo]);
                    }
                }
            }
            else
            {
                printf("adaptor not ready %d, %d\n", frameCount, j);
                [NSThread sleepForTimeInterval:0.1];
            }
            j++;
        }
        if (!append_ok)
        {
            printf("error appending image %d times %d\n, with error.", frameCount, j);
        }
        frameCount++;
    }
        NSLog(@"**************************************************");
    
        //Finish the session:
        [videoWriterInput markAsFinished];
        
        //[videoWriter finishWriting];
        [videoWriter finishWritingWithCompletionHandler:^(){
            
            NSLog (@"finished writing");
            [videoWriter cancelWriting];
         
            //////////////  OK now add an audio file to move file  /////////////////////
            
            AVMutableComposition* mixComposition = [AVMutableComposition composition];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            NSLog(@"paths is %lu",(unsigned long)paths.count);
            
            if (paths.count > 1 || paths.count == 0)
            {
                NSLog(@"if-condition");
                
            }
            else
            {
                documentDirectory = [paths objectAtIndex:0];
                
                // audio input file...
                NSString *audio_inputFilePath = [documentDirectory stringByAppendingPathComponent:@"output.m4a"];
                
                NSLog(@"audio_inputFilePath is %@",audio_inputFilePath);

                NSURL *audio_inputFileUrl = [NSURL fileURLWithPath:audio_inputFilePath];
                
                NSLog(@"audio_inputFileUrl is %@",audio_inputFileUrl);
                
               // [[NSFileManager defaultManager] removeItemAtURL:audioFileOutput error:NULL];
                
                // this is the video file that was just written above, full path to file is in --> videoOutputPath
                NSURL *video_inputFileUrl = [NSURL fileURLWithPath:videoOutputPath];
                
                // create the final video output file as MOV file - may need to be MP4, but this works so far...
                NSString *outputFilePath = [documentsDirectory stringByAppendingPathComponent:@"final_video.mp4"];
                
                videoForSocialSharing = outputFilePath;
                
                NSURL *outputFileUrl = [NSURL fileURLWithPath:outputFilePath];
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:outputFilePath])
                    [[NSFileManager defaultManager] removeItemAtPath:outputFilePath error:nil];
                
                CMTime nextClipStartTime = kCMTimeZero;
                
                AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:video_inputFileUrl options:nil];
                CMTimeRange video_timeRange = CMTimeRangeMake(kCMTimeZero,videoAsset.duration);
                AVMutableCompositionTrack *a_compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
                
                [a_compositionVideoTrack insertTimeRange:video_timeRange ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:nextClipStartTime error:nil];
                
                //nextClipStartTime = CMTimeAdd(nextClipStartTime, a_timeRange.duration);
                
                audioAsset = [AVURLAsset URLAssetWithURL:audio_inputFileUrl options:nil];
                
                if(audioAsset!=nil)
                {
                    NSLog(@"audioAsset!=nil");
                    
                    if (audio_inputFilePath != nil)
                    {
                        CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
                        AVMutableCompositionTrack *b_compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
                        
                        NSLog(@"b_compositionAudioTrack is %@",b_compositionAudioTrack);
                        
                        [b_compositionAudioTrack insertTimeRange:audio_timeRange ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:nextClipStartTime error:nil];
                    }
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Crop Again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [alert show];
                    }
                }
                
                AVAssetExportSession* _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
                //_assetExport.outputFileType = @"com.apple.quicktime-movie";
                _assetExport.outputFileType = @"public.mpeg-4";
                //NSLog(@"support file types= %@", [_assetExport supportedFileTypes]);
                _assetExport.outputURL = outputFileUrl;
                
                [_assetExport exportAsynchronouslyWithCompletionHandler:
                 ^(void ) {
                     //[self saveVideoToAlbum:outputFilePath];
                 }
                 ];
                
                ///// THAT IS IT DONE... the final video file will be written here...
                NSLog(@"DONE.....outputFilePath--->%@", outputFilePath);
                
                
                NSURL *urlForInstagram = [NSURL fileURLWithPath:outputFilePath];
                
                NSLog(@"urlForInstagram is %@",urlForInstagram);
                
                ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                [library writeVideoAtPathToSavedPhotosAlbum:urlForInstagram completionBlock:^(NSURL *assetURL, NSError *error)
                 {
                     NSURL *instagramURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@",urlForInstagram]];
                     
                     NSLog(@"instagramURL is %@",instagramURL);
                     
                     if ([[UIApplication sharedApplication] canOpenURL:instagramURL])
                     {
                         [[UIApplication sharedApplication] openURL:instagramURL];
                     }
                 }];

            }

        }];
        
    NSLog(@"Write Ended");
        
    }
    
     audioAsset = nil;
}

- (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) imageC
{
    CGSize size = CGSizeMake(200,400);
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,[NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,nil];
    CVPixelBufferRef pxbuffer = NULL;
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,size.width,size.height,kCVPixelFormatType_32ARGB,(__bridge CFDictionaryRef) options,&pxbuffer);
    if (status != kCVReturnSuccess)
    {
        NSLog(@"Failed to create pixel buffer");
    }
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, size.width,size.height, 8, 4*size.width, rgbColorSpace,kCGImageAlphaPremultipliedFirst);

    CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(imageC),CGImageGetHeight(imageC)), imageC);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}

#pragma mark - Timer

- (void)timerFired:(NSTimer*)timer
{
    [soundTimer invalidate];
    
    soundTimer = nil;
    
    [self updateDisplay];
}

- (void)stopTimer
{
    [soundTimer invalidate];
    
     soundTimer = nil;
    
    [self updateDisplay];
}

- (BOOL)trimAudio:(float)vocalStartMarker vocalEndMarker:(float)vocalEndMarker songURL:(NSString*)songURL playCroppedSong:(BOOL)playCroppedSong
{
    if (isAlreadyCropped == YES)
    {
        NSLog(@"IsAlready Cropped");
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *directoryPath = [paths objectAtIndex:0];
        directoryPath = [NSString stringWithFormat:@"%@/%@",directoryPath,@"output.m4a",nil];
        NSLog(@"directoryPath is %@",directoryPath);
        newObjAudio = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:directoryPath] error:NULL];
        
        isAlreadyCropped = NO;
        
        if (![newObjAudio isPlaying])
        {
            [newObjAudio play];
            
        }
        else
        {
            [newObjAudio pause];
        }
    }
    else
    {
        AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetAppleM4A];
        
        if (exportSession == nil)
        {
            return NO;
        }
        
        CMTime start = CMTimeMakeWithSeconds(vocalStartMarker, asset.duration.timescale);
        CMTime duration = CMTimeMakeWithSeconds(vocalEndMarker-vocalStartMarker, asset.duration.timescale);
        CMTimeRange exportTimeRange = CMTimeRangeMake(start, duration);
        exportSession.timeRange = exportTimeRange;
        
        exportSession.outputURL = audioFileOutput;
        exportSession.outputFileType = AVFileTypeAppleM4A;
        exportSession.timeRange = exportTimeRange;
        
        if (isVisible == NO)
        {
            slider.hidden = YES;
            positionSlider.hidden = NO;
        }
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^
         {
             if (AVAssetExportSessionStatusCompleted == exportSession.status)
             {
                 NSLog(@"It worked");
                 
                 isAlreadyCropped = YES;
                 
                 if (playCroppedSong == YES)
                 {
                     slider.hidden = NO;
                     positionSlider.hidden = YES;
                     [self.slider setDisplayMode:BJRSWPAudioSetTrimMode];
                     
                     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                     NSString *directoryPath = [paths objectAtIndex:0];
                     directoryPath = [NSString stringWithFormat:@"%@/%@",directoryPath,@"output.m4a",nil];
                     NSLog(@"directoryPath is %@",directoryPath);
                     newObjAudio = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:directoryPath] error:NULL];
                     
                     if (![newObjAudio isPlaying])
                     {
                         [newObjAudio play];
                         
                     }
                     else
                     {
                         [newObjAudio pause];
                     }
                 }
                 
                 
                 //[[NSFileManager defaultManager] removeItemAtPath:filePathForCroppingAudio error:NULL];
             }
             else
             {
                 if (AVAssetExportSessionStatusFailed == exportSession.status)
                 {
                     NSLog(@" It failed... is %@",exportSession.error.localizedDescription);
                 
                     [self Crop];
                     
                     outletOfPauseBtn.hidden = YES;
                     
                 }
             }
         }];
    }
        return YES;
    
}

- (IBAction)valueChanged
{
    isAlreadyCropped = NO;
    
    if (objAudio.duration <15.0)
    {
        if (slider.rightValue - slider.leftValue > 15.0f)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Audio must not be longer than 15 seconds" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        slider.maxValue = objAudio.duration;
    
        int minutes = floor(slider.maxValue/60);
        int seconds = trunc(slider.maxValue - minutes * 60);
        if (seconds<10)
        {
            NSString *currentTimeString = [NSString stringWithFormat:@"%i:0%i" ,minutes,seconds];
            NSLog(@"currentTimeString is %@",currentTimeString);
            self.rightLbl.text =  currentTimeString;
        }
        else
        {
            NSString *currentTimeString = [NSString stringWithFormat:@"%i:%i" ,minutes,seconds];
            NSLog(@"currentTimeString is %@",currentTimeString);
            self.rightLbl.text =  currentTimeString;
        }

        NSLog(@"slider.maxValue is %f",slider.maxValue);
    
   /////////////////////////////////////////////////////////////////////////////
    
        slider.minValue = 0.0f;
        objAudio.currentTime = slider.leftValue;
    
        [objAudio setCurrentTime:slider.leftValue];
    
        double newCurrentTime = objAudio.currentTime;
        int min = floor(newCurrentTime/60);
        int sec = trunc(newCurrentTime - min * 60);
    
        if (sec < 10)
        {
            self.leftLbl.text = [NSString stringWithFormat:@"%i:0%i" ,min,sec];
        }
        else
        {
            self.leftLbl.text = [NSString stringWithFormat:@"%i:%i" ,min,sec];
        }
        objAudio.currentTime = slider.leftValue;
    
    //////////////////////////////////////////////////////////////////////////
    
        [self updateSliderLabels];
    }
}

- (IBAction)selectAudioBTn:(id)sender
{
    if (isPlayClicked == YES)
    {
        NSLog(@"AUdio is Cropped Already");
        
    }
    else
    {
        [self trimAudio:slider.leftValue vocalEndMarker:slider.rightValue songURL:filePathForCroppingAudio playCroppedSong:NO];
    }
    
    outletOfPlayBtn.hidden = NO;
    outletOfPlayBtn.enabled = NO;
    outletOfPauseBtn.hidden = YES;
    [newObjAudio stop];
    
    outletOfSelectAudioBtn.hidden = YES;
    
    self.leftLbl.hidden = NO;
    self.rightLbl.hidden = NO;
    
    outetOfTrimBtn.hidden = YES;
    outletOfCancelBtn.hidden = NO;
    
    slider.hidden = NO;
    slider.enabled = NO;
    
    outletOfDeSelectAudioBtn.hidden = NO;
    _outletOfSliderCover.hidden = YES;
    self.outletOfInstagram.hidden = NO;
    self.outletOfInstagram.enabled = YES;
    
    positionSlider.hidden = YES;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (trimmingMode == NO)
    {
        if (flag == YES)
        {
            NSLog(@"flag is YES");
        }
        else
        {
            NSLog(@"Playback finished unsuccessfully");
        }
        if (isFirstTime > 0)
        {
            if ([repeatMode isEqualToString:@"all"])
            {
                if (currentIndex == currentPlayList.count-1)
                {
                    currentIndex = 0;
                }
                else
                {
                    currentIndex++;
                }
            }
            else if ([repeatMode isEqualToString:@"none"])
            {
                if (currentIndex < currentPlayList.count-1)
                {
                    currentIndex++;
                }
            }
        }
        isFirstTime++;
        
        if (!([repeatMode isEqualToString:@"none"] && currentIndex == currentPlayList.count-1))
        {
            allowPlay = YES;
            [self playSound];
        }
        else
        {
            if (currentPlayList.count == 1)
            {
                if (isFirstTimeNone == 0 && [repeatMode isEqualToString:@"none"])
                {
                    allowPlay = YES;
                    isFirstTimeNone = 1;
                    [self playSound];
                }
            }
        }
        
        NSURL *url = [NSURL URLWithString:[currentPlayList[currentIndex] valueForKey:@"m_file_image"]];
        
        NSLog(@"url is %@",url);
        
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(concurrentQueue, ^{
            image = [[NSData alloc] initWithContentsOfURL:url];
            
            
//            NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)objectAtIndex:0];
//            NSLog(@"image to be saved is %@",documents);
//            
//            NSString *filePath = [documents stringByAppendingPathComponent:@"img.jpg"];
//            [image writeToFile:filePath atomically:YES];
//            
//            NSLog(@"filePath is %@",filePath);

            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (image != nil)
                {
                    imageViewOutlet.image = [UIImage imageWithData:image];
                    timeIncrease.text = @"-:--";
                    songTotalTimeLbl.text = @"-:--";
                }
                else
                {
                    // Cell.selectedCategoryImg.image = [UIImage imageNamed:@"no_image_icon.png"];
                    imageViewOutlet.image = [UIImage imageNamed:@"no_image_icon.png"];
                    timeIncrease.text = @"-:--";
                    songTotalTimeLbl.text = @"-:--";
                }
            });
        });
        imageViewOutlet.image = [UIImage imageWithData:image];
       // positionSlider.hidden = YES;
    }
    else
    {
        NSLog(@"trimming mode == yes");
    }
}

- (IBAction)cancelBtn:(id)sender
{
    self.leftLbl.hidden = YES;
    self.rightLbl.hidden = YES;
    outetOfTrimBtn.hidden = NO;
    outletOfCancelBtn.hidden = YES;
    outletOfSelectAudioBtn.hidden = YES;
    slider.hidden = YES;
    positionSlider.hidden = NO;
    trimmingMode = NO;
    outletOfRepeatBtn.enabled = YES;
    outletOfPreviousBtn.enabled = YES;
    outletOfFarwordBtn.enabled = YES;
    [newObjAudio stop];
    _outletOfInstagram.hidden = NO;
    _outletOfInstagram.enabled = NO;
    
    _outletOfMenuBtn.hidden = NO;
    _outletOfMenuBtn.enabled = YES;
    
    outletOfDeSelectAudioBtn.hidden = YES;
    _outletOfSliderCover.hidden = YES;
    outletOfPlayBtn.hidden = NO;
    outletOfPlayBtn.enabled = YES;
    [self btnPlay:self];
}

- (IBAction)deSelectBtn:(id)sender
{
    positionSlider.hidden = YES;
    
    self.outletOfInstagram.hidden = YES;
    
    slider.hidden = NO;
    slider.enabled = YES;
    
    self.leftLbl.hidden = NO;
    self.rightLbl.hidden = NO;
    timeIncrease.hidden = YES;
    songTotalTimeLbl.hidden = YES;
    
    timeIncrease.hidden = YES;
    songTotalTimeLbl.hidden = YES;
    outletOfPlayBtn.hidden = NO;
    
    trimmingMode = YES;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectorys = [paths objectAtIndex:0];
    
    NSLog(@"documentDirectory is %@",documentDirectorys);
    
    NSURL *audioFileInput = [NSURL fileURLWithPath:filePathForCroppingAudio];
    
    requiredOutputPath = [documentDirectorys stringByAppendingPathComponent:@"output.m4a"];
    
    audioFileOutput = [NSURL fileURLWithPath:requiredOutputPath];
    
    if (!audioFileInput || !audioFileOutput)
    {
        NSLog(@"return NO");
    }
    
    [[NSFileManager defaultManager] removeItemAtURL:audioFileOutput error:NULL];
    asset = [AVAsset assetWithURL:audioFileInput];
    
    NSLog(@"asset is %@",audioFileOutput);
    
    if (isVisible == NO)
    {
        if (trimmingMode == YES)
        {
            slider.hidden = NO;
            slider.enabled = YES;
            positionSlider.hidden = YES;
            _outletOfSliderCover.hidden = YES;
            self.outletOfInstagram.hidden = NO;
            self.outletOfInstagram.enabled = NO;
            
            outletOfPlayBtn.hidden = NO;
            outletOfPlayBtn.enabled = YES;
            
            [slider setDisplayMode:BJRSWPAudioSetTrimMode];
            
            [slider addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
        }
        else
        {
            NSLog(@"Trimming Mode else");
        }
    }
    else
    {
        NSLog(@"Not Visible");
    }
    
    outletOfPauseBtn.hidden = YES;
    outletOfRepeatBtn.enabled = NO;
    outletOfPreviousBtn.enabled = NO;
    outletOfFarwordBtn.enabled = NO;
    outletOfDeSelectAudioBtn.hidden = YES;
    outletOfSelectAudioBtn.hidden = NO;
    [objAudio pause];
    outetOfTrimBtn.hidden = YES;
    outletOfCancelBtn.hidden = NO;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    blurView.hidden = YES;
    
    outetOfTrimBtn.hidden = NO;
    
    [UIView transitionWithView:popUpView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        
        popUpView.hidden = YES;
        
        self.tabBarController.tabBar.hidden = NO;
        
        NSLog(@"presenting popUpView");
        
    } completion:nil
     ];
}

- (void)showActionSheet:(id)sender //Define method to show action sheet
{
    NSString *actionSheetTitle = @"Share";                  //Action Sheet Title
    NSString *destructiveTitle = @"Destructive Button";     //Action Sheet Button Titles
    NSString *other1 = @"Like";
    NSString *other2 = @"Repost";
    NSString *other3 = @"Comment";
    NSString *other4 = @"Instagram";
    NSString *other5 = @"Share";
    NSString *cancelTitle = @"Cancel";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle delegate:self cancelButtonTitle:cancelTitle destructiveButtonTitle:destructiveTitle otherButtonTitles:other1, other2, other3,other4,other5, nil];
    
    //[actionSheet showInView:self.view];
    [actionSheet showInView:[[[UIApplication sharedApplication] delegate] window]];
}


- (IBAction)Menu:(id)sender
{
    blurView.hidden = NO;
    
   // [self showActionSheet:sender];
    
    
    
//
//    [actionSheet showInView:[[[UIApplication sharedApplication] delegate] window]];
//
//    self.tabBarController.tabBar.hidden = YES;
    
    
    
    
    if (isDisplayMenu == NO)
    {
        outetOfTrimBtn.hidden = YES;
        outletOfSelectAudioBtn.hidden = YES;
        outletOfDeSelectAudioBtn.hidden = YES;
        outletOfCancelBtn.hidden = YES;

        [UIView transitionWithView:popUpView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
             NSLog(@"isDisplayMenu == YES");
            
            isDisplayMenu = YES;
            popUpView.hidden = NO;
            
            NSLog(@"presenting popUpView");
        
            
        } completion:nil
    
         ];
    }
    else
    {
        blurView.hidden = YES;
        
        outetOfTrimBtn.hidden = NO;
        
        NSLog(@"isDisplayMenu == NO");
        
        [UIView transitionWithView:popUpView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            isDisplayMenu = NO;
            popUpView.hidden = YES;

            NSLog(@"presenting popUpView");
            
        } completion:nil
         ];
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (IBAction)likeBtn:(id)sender
{
    NSLog(@"like button");
}

- (IBAction)repostBtn:(id)sender
{
    NSLog(@"Repost button");
}

- (IBAction)commentBtn:(id)sender
{
    NSLog(@"comment button");
}

- (IBAction)shareBtn:(id)sender
{
    NSLog(@"ShareBtn pressed fro sharing on social media");
    
    NSString *messages = @"Slippery Slick video";
    
    NSString *audioURl = [currentPlayList[currentIndex] valueForKey:@"audio_url"];
    
    NSArray *shareItems = [NSArray arrayWithObjects:messages,audioURl,nil];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
//    
//    if ([buttonTitle isEqualToString:@"Other Button 1"])
//    {
//        NSLog(@"buttonIndex == 1");
//    }
//    
//}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    [actionSheet.subviews enumerateObjectsUsingBlock:^(id _currentView, NSUInteger idx, BOOL *stop)
    {
        if ([_currentView isKindOfClass:[UIButton class]])
        {
            ((UIButton *)_currentView).contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            ((UIButton *)_currentView).contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        }
    }];
}



-(void)videoMaker
{
    NSLog(@"slider.rightValue - slider.leftValue %f",slider.rightValue - slider.leftValue);
    
    if (slider.rightValue - slider.leftValue > 15.0f)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Audio must not be longer than 15 seconds" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        slider.hidden = NO;
        positionSlider.hidden = YES;
        slider.enabled = NO;
        
        if (isVisible == NO)
        {
            NSLog(@"%f %f", slider.leftValue, slider.rightValue);
            
        }
        
        NSError *error = nil;
        
        // set up file manager, and file videoOutputPath, remove "test_output.mp4" if it exists...
        //NSString *videoOutputPath = @"/Users/someuser/Desktop/test_output.mp4";
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *documentsDirectory = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
        NSString *videoOutputPath = [documentsDirectory stringByAppendingPathComponent:@"test_output.mp4"];
        
        //NSLog(@"-->videoOutputPath= %@", videoOutputPath);
        // get rid of existing mp4 if exists...
        
        if ([fileMgr removeItemAtPath:videoOutputPath error:&error] != YES)
            NSLog(@"Unable to delete file: %@", [error localizedDescription]);
        
        CGSize imageSize = CGSizeMake(400,200);
        NSUInteger fps = slider.rightValue - slider.leftValue;
        
        NSLog(@"fps is %lu",(unsigned long)fps);
        
        NSMutableArray *imageArray;
        
        NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"icon-600X300.png"];
        
        NSLog(@"str is %@",str);
        
        NSArray *imagePaths = [NSArray arrayWithObjects:str,str,str,nil];
        
        imageArray = [[NSMutableArray alloc] initWithCapacity:imagePaths.count];
        
        NSLog(@"-->imageArray.count= %lu",(unsigned long)imageArray.count);
        
        for (NSString* path in imagePaths)
        {
            [imageArray addObject:[UIImage imageWithContentsOfFile:path]];
            //NSLog(@"-->image path= %@", path);
        }
        
        //////////////     end setup    ///////////////////////////////////
        
        NSLog(@"Start building video from defined frames.");
        
        AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:videoOutputPath] fileType:AVFileTypeQuickTimeMovie error:&error];
        NSParameterAssert(videoWriter);
        
        NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey,[NSNumber numberWithInt:imageSize.width], AVVideoWidthKey,[NSNumber numberWithInt:imageSize.height], AVVideoHeightKey,nil];
        
        AVAssetWriterInput* videoWriterInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
        
        AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:videoWriterInput sourcePixelBufferAttributes:nil];
        
        NSParameterAssert(videoWriterInput);
        NSParameterAssert([videoWriter canAddInput:videoWriterInput]);
        videoWriterInput.expectsMediaDataInRealTime = YES;
        [videoWriter addInput:videoWriterInput];
        
        //Start a session:
        [videoWriter startWriting];
        [videoWriter startSessionAtSourceTime:kCMTimeZero];
        
        CVPixelBufferRef buffer = NULL;
        
        //convert uiimage to CGImage.
        int frameCount = 0;
        double numberOfSecondsPerFrame = fps/3;
        double frameDuration = fps *numberOfSecondsPerFrame;
        
        //for(VideoFrame * frm in imageArray)
        NSLog(@"**************************************************");
        
        for(UIImage * img in imageArray)
        {
            //UIImage * img = frm._imageFrame;
            buffer = [self pixelBufferFromCGImage:[img CGImage]];
            
            BOOL append_ok = NO;
            int j = 0;
            while (!append_ok && j < fps)
            {
                if (adaptor.assetWriterInput.readyForMoreMediaData)
                {
                    //print out status:
                    NSLog(@"Processing video frame (%d,%lu)",frameCount,(unsigned long)[imageArray count]);
                    
                    CMTime frameTime = CMTimeMake(frameCount*frameDuration,(int32_t) fps);
                    append_ok = [adaptor appendPixelBuffer:buffer withPresentationTime:frameTime];
                    
                    if(!append_ok)
                    {
                        NSError *error = videoWriter.error;
                        
                        if(error!=nil)
                        {
                            NSLog(@"Unresolved error %@,%@.", error, [error userInfo]);
                        }
                    }
                }
                else
                {
                    printf("adaptor not ready %d, %d\n", frameCount, j);
                    [NSThread sleepForTimeInterval:0.1];
                }
                j++;
            }
            if (!append_ok)
            {
                printf("error appending image %d times %d\n, with error.", frameCount, j);
            }
            frameCount++;
        }
        NSLog(@"**************************************************");
        
        //Finish the session:
        [videoWriterInput markAsFinished];
        //    [videoWriter finishWriting];
        [videoWriter finishWritingWithCompletionHandler:^(){
            
            NSLog (@"finished writing");
            [videoWriter cancelWriting];
            
            //////////////  OK now add an audio file to move file  /////////////////////
            
            AVMutableComposition *mixComposition = [AVMutableComposition composition];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            NSLog(@"paths is %lu",(unsigned long)paths.count);
            
            if (paths.count > 1 || paths.count == 0)
            {
                NSLog(@"if-condition");
            }
            else
            {
                documentDirectory = [paths objectAtIndex:0];
                
                // audio input file...
                NSString *audio_inputFilePath = [documentDirectory stringByAppendingPathComponent:@"output.m4a"];
                
                NSLog(@"audio_inputFilePath is %@",audio_inputFilePath);
                
                NSURL *audio_inputFileUrl = [NSURL fileURLWithPath:audio_inputFilePath];
                
                NSLog(@"audio_inputFileUrl is %@",audio_inputFileUrl);
                
                // [[NSFileManager defaultManager] removeItemAtURL:audioFileOutput error:NULL];
                
                // this is the video file that was just written above, full path to file is in --> videoOutputPath
                NSURL *video_inputFileUrl = [NSURL fileURLWithPath:videoOutputPath];
                
                // create the final video output file as MOV file - may need to be MP4, but this works so far...
                NSString *outputFilePath = [documentsDirectory stringByAppendingPathComponent:@"final_video.mp4"];
                
                videoForSocialSharing = outputFilePath;
                
                NSURL *outputFileUrl = [NSURL fileURLWithPath:outputFilePath];
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:outputFilePath])
                    [[NSFileManager defaultManager] removeItemAtPath:outputFilePath error:nil];
                
                CMTime nextClipStartTime = kCMTimeZero;
                
                AVURLAsset *videoAsset = [[AVURLAsset alloc]initWithURL:video_inputFileUrl options:nil];
                CMTimeRange video_timeRange = CMTimeRangeMake(kCMTimeZero,videoAsset.duration);
                AVMutableCompositionTrack *a_compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
                
                [a_compositionVideoTrack insertTimeRange:video_timeRange ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:nextClipStartTime error:nil];
                
                //nextClipStartTime = CMTimeAdd(nextClipStartTime, a_timeRange.duration);
                
                audioAsset = [AVURLAsset URLAssetWithURL:audio_inputFileUrl options:nil];
                
                if(audioAsset!=nil)
                {
                    NSLog(@"audioAsset!=nil");
                    
                    if (audio_inputFilePath != nil)
                    {
                        CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
                        AVMutableCompositionTrack *b_compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
                        
                        NSLog(@"b_compositionAudioTrack is %@",b_compositionAudioTrack);
                        
                        [b_compositionAudioTrack insertTimeRange:audio_timeRange ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:nextClipStartTime error:nil];
                    }
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Crop Again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [alert show];
                    }
                }
                
                AVAssetExportSession *_assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
                //_assetExport.outputFileType = @"com.apple.quicktime-movie";
                _assetExport.outputFileType = @"public.mpeg-4";
                //NSLog(@"support file types= %@", [_assetExport supportedFileTypes]);
                _assetExport.outputURL = outputFileUrl;
                
                [_assetExport exportAsynchronouslyWithCompletionHandler:
                 ^(void )
                {
                     //[self saveVideoToAlbum:outputFilePath];
                 }
                 ];
                
                ///// THAT IS IT DONE... the final video file will be written here...
                NSLog(@"DONE.....outputFilePath--->%@", outputFilePath);
            }
        }];
        
        NSLog(@"Write Ended");
        
    }
    
    audioAsset = nil;
}

- (IBAction)CancelFromPopUp:(id)sender
{
    blurView.hidden = YES;
    
    outetOfTrimBtn.hidden = NO;
    
    [UIView transitionWithView:popUpView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                        
        popUpView.hidden = YES;

        self.tabBarController.tabBar.hidden = NO;
        
        NSLog(@"presenting popUpView");
                        
    } completion:nil
     ];
}

-(void) shareOnTwitterWithVideo:(NSDictionary*)params
{
    NSString *text = params[@"text"];
    NSData *dataVideo = params[@"video"];
    NSString *lengthVideo = [NSString stringWithFormat:@"%d", [params[@"length"] intValue]];
    NSString *url = @"https://upload.twitter.com/1.1/media/upload.json";
    
    __block NSString *mediaID;
    
    if([[Twitter sharedInstance] session])
    {
        client = [[Twitter sharedInstance] APIClient];
        NSError *error;
        // First call with command INIT
        message =  @{ @"status":text,@"command":@"INIT",@"media_type":@"video/mp4",@"total_bytes":lengthVideo};
        NSURLRequest *preparedRequest = [client URLRequestWithMethod:@"POST" URL:url parameters:message error:&error];
        
        [client sendTwitterRequest:preparedRequest completion:^(NSURLResponse *urlResponse, NSData *responseData, NSError *error)
         {
             if(!error)
             {
                 NSError *jsonError;
                 NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                 
                 mediaID = [json objectForKey:@"media_id_string"];
                 
                 NSString *userID = [Twitter sharedInstance].sessionStore.session.userID;
                 client = [[TWTRAPIClient alloc] initWithUserID:userID];
                
                 NSError *error;
                 NSString *videoString = [dataVideo base64EncodedStringWithOptions:0];
                 // Second call with command APPEND
                 message = @{@"command" : @"APPEND",@"media_id" : mediaID,@"segment_index" : @"0",@"media" : videoString};
                 
                 NSURLRequest *preparedRequest = [client URLRequestWithMethod:@"POST" URL:url parameters:message error:&error];
                 
                 [client sendTwitterRequest:preparedRequest completion:^(NSURLResponse *urlResponse, NSData *responseData, NSError *error)
                  {
                      if(!error)
                      {
                          client = [[Twitter sharedInstance] APIClient];
                          NSError *error;
                          // Third call with command FINALIZE
                          message = @{@"command" : @"FINALIZE",@"media_id" : mediaID};
                          
                          NSURLRequest *preparedRequest = [client URLRequestWithMethod:@"POST" URL:url parameters:message error:&error];
                          
                          [client sendTwitterRequest:preparedRequest completion:^(NSURLResponse *urlResponse, NSData *responseData, NSError *error)
                           {
                               if(!error)
                               {
                                   client = [[Twitter sharedInstance] APIClient];
                                   NSError *error;
                                   // publish video with status
                                   NSString *url = @"https://api.twitter.com/1.1/statuses/update.json";
                                   NSMutableDictionary *msg = [[NSMutableDictionary alloc] initWithObjectsAndKeys:text,@"status",@"true",@"wrap_links",mediaID, @"media_ids", nil];
                                   NSURLRequest *preparedRequest = [client URLRequestWithMethod:@"POST" URL:url parameters:msg error:&error];
                                   
                                   [client sendTwitterRequest:preparedRequest completion:^(NSURLResponse *urlResponse, NSData *responseData, NSError *error)
                                    {
                                        if(!error)
                                        {
                                            NSError *jsonError;
                                            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                                            NSLog(@"%@", json);
                                        }
                                        else
                                        {
                                            NSLog(@"Error: %@", error);
                                        }
                                    }];
                               }
                               else
                               {
                                   NSLog(@"Error command FINALIZE: %@", error);
                               }
                           }];
                      }
                      else
                      {
                          NSLog(@"Error command APPEND: %@", error);
                      }
                  }];
             }
             else
             {
                 NSLog(@"Error command INIT: %@", error);
             }
             
         }];
    }
}
@end
