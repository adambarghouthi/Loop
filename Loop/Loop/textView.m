//
//  textView.m
//  Loop
//
//  Created by Adam Albarghouthi on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import "textView.h"

@implementation textView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        
        self.tV = [[UITextView alloc] initWithFrame:CGRectMake(15, 0, 3*width/4, height/11)];
        self.tV.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15.0f];
        
        
        
        [self addSubview:self.tV];
        
    }
    
    return self;
}

@end
