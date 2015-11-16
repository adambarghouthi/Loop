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
        
        self.userImg = [[UIButton alloc] initWithFrame:CGRectMake(width/2 - width/14, 15, width/7, width/7)];
        self.userImg.clipsToBounds = YES;
        self.userImg.layer.cornerRadius = width/14;
        [self.userImg setBackgroundColor:[UIColor lightGrayColor]];
        self.userImg.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:25.0];
        [self.userImg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.userImg];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.userImg.frame) + 10.0f, width - 30.0f, 15.0f)];
        self.textView.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15];
        self.textView.textColor = [UIColor darkGrayColor];
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
