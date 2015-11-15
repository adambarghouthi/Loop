//
//  textView.m
//  Loop
//
//  Created by Adam Albarghouthi on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import "textView.h"

static NSInteger MAX_HEIGHT = 105;
static NSInteger MIN_HEIGHT = 45;
@implementation textView
CGFloat _currentKeyboardHeight = 0.0f;
CGRect previousRect;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        

        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width , 0.5)];
        [separatorView setBackgroundColor:[UIColor grayColor]];
        self.tV = [[UITextView alloc] initWithFrame:CGRectMake(10,separatorView.frame.size.height, 3*frame.size.width/4 , frame.size.height-5)];
//                   CGRectMake(15, height-60, 3*width/4, height/16)];
        self.tV.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15.0f];
        
        self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.tV.frame.size.width + 15, 0, frame.size.width - self.tV.frame.size.width -30, frame.size.height)];
        [self.sendBtn setTitle:@"send" forState:UIControlStateNormal];
        [self.sendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//
        [self addSubview:separatorView];
        [self addSubview:self.tV];
        [self addSubview:self.sendBtn];
        
        self.tV.delegate = self;
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

        previousRect = CGRectZero;
    }
    
    return self;
}

#pragma textView Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText: (NSString *)text
{
    
    if([text isEqualToString:@"\n"]) // new line
    {
        [self updateTextFieldFrame:YES];
    }else {
        
        if([text isEqualToString:@""]) // backspace
        {
            textView.selectedRange = range;
            NSString *selectedText = [textView textInRange:[textView selectedTextRange]];
            
            if ([selectedText isEqualToString:@"\n"]) { // line change
                [self updateTextFieldFrame:NO];
            }
        }
    }

    return YES;
}

-(void) updateTextFieldFrame:(BOOL) enlargeHeight{
    
    CGRect newTextViewFrame = [self.tV frame];
    CGRect newFrame = [self frame];
    
    if (enlargeHeight && self.tV.frame.size.height < MAX_HEIGHT){
        
        //TextView
        newTextViewFrame.size.height = self.tV.frame.size.height + 9;
        
        //TextView Container
        newFrame.size.height = self.frame.size.height + 9;
        newFrame.origin.y = self.frame.origin.y - 9;

    }else if (!enlargeHeight && self.tV.frame.size.height > MIN_HEIGHT){
        
        newTextViewFrame.size.height = self.tV.frame.size.height - 9;

        newFrame.size.height = self.frame.size.height - 9;
        newFrame.origin.y = self.frame.origin.y + 9;

    }
    
    [UIView animateWithDuration:0.25 animations:^
     {
         [self.tV setFrame:newTextViewFrame];
         [self setFrame:newFrame];
     }];

}

- (void) textViewDidBeginEditing:(UITextView*)textView {
    
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
