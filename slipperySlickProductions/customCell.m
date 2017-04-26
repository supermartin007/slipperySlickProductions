//
//  customCell.m
//  slipperySlickProductions
//
//  Created by Mrinal Khullar on 7/9/15.
//  Copyright (c) 2015 Mrinal Khullar. All rights reserved.
//

#import "customCell.h"

@implementation customCell
@synthesize discoverGenreImgView,discoverGenreSongtrack,discoverGenreCategoryName;
@synthesize postArtist,postImg,postViews,postSongName,postSongDuration;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
