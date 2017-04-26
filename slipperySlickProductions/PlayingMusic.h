//
//  PlayingMusic.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/13/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BJRangeSliderWithProgress.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SettingViewController.h"
#import "MBProgressHUD.h"
#import "customCell.h"
#import "AssetsLibrary/AssetsLibrary.h"
#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
@class TWTRAPIClient;



extern AVAudioPlayer *objAudio;
extern NSString *currentURL;
extern NSUInteger currentIndex;
extern NSMutableArray *currentPlayList;
extern NSString *repeatMode;
extern NSString *strNavigationTitle;
extern NSString *songImg;
extern NSString *strSongTotalTime;
extern int noOfUnPlayableSongs;
extern BOOL allowPlay;
extern int isFirstTimeNone;
extern UIImage *selectedImg;
extern NSString *currentSongId;
extern  NSData *soundData;

@interface PlayingMusic : UIViewController<AVAudioPlayerDelegate,UIDocumentInteractionControllerDelegate,MBProgressHUDDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate>
{
    NSTimer *soundTimer;
    UIDocumentInteractionController *docFile;
    BOOL isPlayingNextSong;
    NSMutableArray *soundPlayers;
  //  NSData *soundData;
    BJRangeSliderWithProgress *slider;
    NSMutableArray *postArray;
    NSString *documentDirectory;
    BOOL isPlayClicked;
    BOOL isAlreadyCropped;
    AVURLAsset *audioAsset;
    NSString *videoForSocialSharing;
    BOOL isShareOnInstagram;
    BOOL isDisplayMenu;
    TWTRAPIClient *client;
    NSDictionary *message;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageViewOutlet;
@property (weak, nonatomic) IBOutlet UILabel *songLbl;
@property (weak, nonatomic) IBOutlet UILabel *songTotalTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeIncrease;
@property (weak, nonatomic) IBOutlet UILabel *artistLbl;

@property (weak, nonatomic) IBOutlet UIButton *outletOfPlayBtn;
@property (weak, nonatomic) IBOutlet UIButton *outletOfPreviousBtn;
@property (weak, nonatomic) IBOutlet UIButton *outletOfPauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *outletOfFarwordBtn;
@property (weak, nonatomic) IBOutlet UIButton *outletOfRepeatBtn;
@property (weak, nonatomic) IBOutlet UIButton *outetOfTrimBtn;
@property (weak, nonatomic) IBOutlet UIButton *outletOfCancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *outletOfSelectAudioBtn;
//@property (weak, nonatomic) IBOutlet UIButton *oultetOfUploadBtn;
@property (weak, nonatomic) IBOutlet UIView *wrapperView;

@property(nonatomic,strong)IBOutlet BJRangeSliderWithProgress *slider;
@property (weak, nonatomic) IBOutlet UISlider *positionSlider;
@property (weak, nonatomic) IBOutlet UIView *loaderView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loader;

@property(nonatomic,strong) NSString *strImage;
@property(nonatomic,strong) NSString *strSongTotalTime;
@property(nonatomic,strong) NSString *strArtistName;
@property(nonatomic,strong) NSArray *tempSounds;
@property (weak, nonatomic) IBOutlet UILabel *leftLbl;
@property (weak, nonatomic) IBOutlet UILabel *rightLbl;
@property (weak, nonatomic) IBOutlet UIButton *outletOfDeSelectAudioBtn;

@property (weak, nonatomic) IBOutlet UIView *outletOfSliderCover;

@property (weak, nonatomic) IBOutlet UIButton *outletOfInstagram;
@property (weak, nonatomic) IBOutlet UIButton *outletOfMenuBtn;
@property (weak, nonatomic) IBOutlet UIButton *outletOfCancelFromPopUp;

- (IBAction)sliderValueChange;
- (IBAction)btnPlay:(id)sender;
- (IBAction)btnPause:(id)sender;
- (IBAction)btnRepeat:(id)sender;
- (IBAction)btnNextSong:(id)sender;
- (IBAction)btnPreviousSong:(id)sender;
- (IBAction)btnIncVolume:(id)sender;
- (IBAction)btnDecVolume:(id)sender;
- (IBAction)trimBtn:(id)sender;
- (IBAction)selectAudioBTn:(id)sender;
- (IBAction)shareBtnForInstagram:(id)sender;
- (IBAction)cancelBtn:(id)sender;
- (IBAction)deSelectBtn:(id)sender;
- (IBAction)Menu:(id)sender;
- (IBAction)likeBtn:(id)sender;

- (IBAction)repostBtn:(id)sender;

- (IBAction)commentBtn:(id)sender;
- (IBAction)shareBtn:(id)sender;

-(void)updateSlider;
- (void) playSound;
- (BOOL)trimAudio:(float)vocalStartMarker vocalEndMarker:(float)vocalEndMarker songURL:(NSString*)songURL playCroppedSong:(BOOL)playCroppedSong;

@property (weak, nonatomic) IBOutlet UIView *popUpView;
- (IBAction)CancelFromPopUp:(id)sender;


// UNDER MENU SECTION //

@property (weak, nonatomic) IBOutlet UIButton *likeLbl;
@property (weak, nonatomic) IBOutlet UIButton *repostLbl;
@property (weak, nonatomic) IBOutlet UIButton *commentLbl;
@property (weak, nonatomic) IBOutlet UIButton *shareLbl;
@property (weak, nonatomic) IBOutlet UIView *blurView;

@end


