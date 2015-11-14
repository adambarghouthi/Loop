//
//  textView.m
//  Loop
//
//  Created by Adam Albarghouthi on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import "textView.h"

@implementation textView
CGFloat _currentKeyboardHeight = 0.0f;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        
        self.tV = [[UITextView alloc] initWithFrame:CGRectMake(15, height-60, 3*width/4, height/16)];
        self.tV.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15.0f];
        
        self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.tV.frame.size.width + 15, height-70, width - self.tV.frame.size.width -30, height/11)];
        [self.sendBtn setTitle:@"send" forState:UIControlStateNormal];
        [self.sendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [self addSubview:self.tV];
        [self addSubview:self.sendBtn];
        self.tV.delegate = self;
//        [self setBackgroundColor:[UIColor redColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

        
    }
    
    return self;
}

#pragma textView Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText: (NSString *)text
{
    //Detect newline
    BOOL newLine = [text isEqualToString:@"\n"];
    if(newLine)
    {
        [self updateTextFieldFrame];
    }
    return YES;
}

-(void) updateTextFieldFrame{
    
    CGRect newFrame = [self.tV frame];
    newFrame.size.height = self.tV.frame.size.height + 9;
    newFrame.origin.y = self.tV.frame.origin.y - 9;
    
    [UIView animateWithDuration:0.25 animations:^
     {
         [self.tV setFrame:newFrame];
     }];
}

- (void) textViewDidBeginEditing:(UITextView*)textView {
    
}
- (void) textViewDidChange:(UITextView*)textView {
    
}

#pragma keyboard events
- (void)keyboardWillShow:(NSNotification*)notification {
    
    NSDictionary* d = [notification userInfo];
    CGRect keyboardFrame = [d[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect newFrame = [self frame];
    newFrame.origin.y -= keyboardFrame.size.height; // tweak here to adjust the moving position
    
    [UIView animateWithDuration:0.25 animations:^
     {
         [self setFrame:newFrame];
         
     }];
}

- (void)keyboardWillBeHidden:(NSNotification*)notification {
    
    NSDictionary* d = [notification userInfo];
    CGRect keyboardFrame = [d[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect newFrame = [self frame];
    newFrame.origin.y += keyboardFrame.size.height; // tweak here to adjust the moving position
    
    [UIView animateWithDuration:0.25 animations:^
     {
         [self setFrame:newFrame];
     }];
    
}
#pragma touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.tV endEditing:YES];
}
@end
