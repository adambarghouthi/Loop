//
//  textView.m
//  Loop
//
//  Created by Adam Albarghouthi on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import "textView.h"
#import <Firebase/Firebase.h>

@implementation textView
CGFloat _currentKeyboardHeight = 0.0f;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width , 0.5)];
        [separatorView setBackgroundColor:[UIColor grayColor]];
        self.tF = [[UITextField alloc] initWithFrame:CGRectMake(10,0, 3*frame.size.width/4 , frame.size.height)];
        self.tF.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15.0f];
        self.tF.placeholder = @"Loop tracks your news...";
        
        self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.tF.frame.size.width + 15, 0, frame.size.width - self.tF.frame.size.width -30, frame.size.height)];
        self.sendBtn.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:17.0f];
        [self.sendBtn setTitle:@"send" forState:UIControlStateNormal];
        [self.sendBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:35.0/255.0 blue:206.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self addSubview:separatorView];
        [self addSubview:self.tF];
        [self addSubview:self.sendBtn];
        
        self.tF.delegate = self;
        [self setBackgroundColor:[UIColor whiteColor]];

    }
    
    return self;
}

@end
