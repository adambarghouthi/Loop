//
//  TextCell.m
//  Loop
//
//  Created by Professional on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import "TextCell.h"

@implementation TextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        
        self.view = [[UIView alloc] initWithFrame:CGRectMake(15, 7.5, width -30, height/9 - 15)];
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.clipsToBounds = YES;
        self.view.layer.cornerRadius = 5.0f;
        [self.contentView addSubview:self.view];
        
        self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(7.5,7.5, self.view.frame.size.height - 15, self.view.frame.size.height - 15)];
        self.logoImage.clipsToBounds = YES;
        self.logoImage.layer.cornerRadius = (self.view.frame.size.height-15)/2;
        [self.view addSubview:self.logoImage];
        
        self.contentField = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.logoImage.frame) + 10, CGRectGetMinY(self.logoImage.frame), self.view.frame.size.width - self.logoImage.frame.size.width - 17.5, self.logoImage.frame.size.height)];
        self.contentField.textColor = [UIColor lightGrayColor];
        self.contentField.backgroundColor = [UIColor clearColor];
        self.contentField.numberOfLines = 10000000;
        self.contentField.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15.0f];
        [self.view addSubview:self.contentField];
        
        // add shadow to contentfield
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
        self.view.layer.masksToBounds = NO;
        self.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.view.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.view.layer.shadowOpacity = 0.1f;
        self.view.layer.shadowPath = shadowPath.CGPath;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
