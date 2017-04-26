//
//  SettingViewController.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/13/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "SettingViewController.h"
#import <FacebookSDK/FacebookSDK.h> 

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize outletOfNotificationBtn;

- (void)viewDidLoad
{
    UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70.0,outletOfNotificationBtn.frame.origin.y, 20.0,10.0)];
    mySwitch.layer.cornerRadius = 16.0;
    // mySwitch.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mySwitch];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)notificationsBtn:(id)sender
{
    NSLog(@"notificationsBtn clicked");
}

- (IBAction)signOutBtn:(id)sender
{
    NSLog(@"signOutBtn clicked");
    
    [objAudio stop];
    [[NSUserDefaults standardUserDefaults]setBool:false forKey:@"Relogin"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    WelcomeView * viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"goBack"];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:nav animated:NO completion:nil];
}

- (IBAction)recordVideo:(id)sender
{
    NSLog(@"recordVideo");
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Device has no camera" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerController.delegate = self;
        pickerController.showsCameraControls = YES;
        pickerController.allowsEditing = YES;
        pickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        pickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
        // kUTTypeMovie is actually an NSString.
        pickerController.videoMaximumDuration = 30.0f; // limits video length to 30 seconds.
        [self presentViewController:pickerController animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // grab our movie URL
    NSURL *chosenMovie = [info objectForKey:UIImagePickerControllerMediaURL];
    
    // save it to the documents directory
    NSURL *fileURL = [self grabFileURL:@"video.mov"];
    NSData *movieData = [NSData dataWithContentsOfURL:chosenMovie];
    [movieData writeToURL:fileURL atomically:YES];
    
    // save it to the Camera Roll
    UISaveVideoAtPathToSavedPhotosAlbum([chosenMovie path], nil, nil, nil);
    
    // and dismiss the picker
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSURL*)grabFileURL:(NSString *)fileName
{
    
    // find Documents directory
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    // append a file name to it
    documentsURL = [documentsURL URLByAppendingPathComponent:fileName];
    
    return documentsURL;
}


@end
