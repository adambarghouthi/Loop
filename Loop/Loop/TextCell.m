//
//  TextCell.m
//  Loop
//
//  Created by Professional on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import "TextCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;

        self.view = [[UIView alloc] initWithFrame:CGRectMake(15, 7.5, width-30, height)];
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.layer.cornerRadius = 5.0f;
        [self.contentView addSubview:self.view];
        
        self.userImg = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - width/14, 15, width/7, width/7)];
        self.userImg.clipsToBounds = YES;
        self.userImg.layer.cornerRadius = width/14;
        [self.contentView addSubview:self.userImg];
        
//        self.nameDate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userImg.frame) + 5.0f, 15.0f, width - 20.0f - width/7, width/7)];
//        self.nameDate.font = [UIFont fontWithName:@"Montserrat" size:width/21];
//        self.nameDate.textColor = [UIColor whiteColor];
//        [self addSubview:self.nameDate];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.userImg.frame) + 10.0f, width - 30.0f, 15.0f)];
        self.textView.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15];
        self.textView.textColor = [UIColor lightGrayColor];
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.scrollEnabled = NO;
        self.textView.editable = NO;
        self.textView.userInteractionEnabled = NO;
        self.textView.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.textView];

    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
