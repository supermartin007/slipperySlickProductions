//
//  customCell.h
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/9/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customCell : UITableViewCell

// custom cell for ALBUM VIEW CONTROLLER




@property (weak, nonatomic) IBOutlet UIImageView *discoverGenreImgView;
@property (weak, nonatomic) IBOutlet UILabel *discoverGenreSongtrack;
@property (weak, nonatomic) IBOutlet UILabel *discoverGenreCategoryName;



// custom cell for SELECTED CATEGORY CONTROLLER

@property (weak, nonatomic) IBOutlet UILabel *albumArtist;
@property (weak, nonatomic) IBOutlet UILabel *albumSong;
@property (weak, nonatomic) IBOutlet UILabel *albumSongViews;
@property (weak, nonatomic) IBOutlet UILabel *albumSongTIme;
@property (weak, nonatomic) IBOutlet UIImageView *selectedCategoryImg;




//  custom cell for POST TABLE VIEW IN PROFILE
@property (weak, nonatomic) IBOutlet UIImageView *postImg;
@property (weak, nonatomic) IBOutlet UILabel *postArtist;
@property (weak, nonatomic) IBOutlet UILabel *postSongName;
@property (weak, nonatomic) IBOutlet UILabel *postViews;
@property (weak, nonatomic) IBOutlet UILabel *postSongDuration;

@end




