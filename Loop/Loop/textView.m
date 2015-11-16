//
//  textView.m
//  Loop
//
//  Created by Adam Albarghouthi on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import "textView.h"
#import <Firebase/Firebase.h>

<<<<<<< HEAD
@implementation textView
CGFloat _currentKeyboardHeight = 0.0f;
=======
static NSInteger MAX_HEIGHT = 105;
static NSInteger MIN_HEIGHT = 45;

static NSInteger GROWTH_SIZE = 9;

@implementation textView
CGFloat _currentKeyboardHeight = 0.0f;
CGRect defaultFrame;
CGRect defaultTextViewFrame;
CGFloat previousHeigth;
CGFloat textHeigth;

>>>>>>> origin/master

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width , 0.5)];
        [separatorView setBackgroundColor:[UIColor grayColor]];
        self.tF = [[UITextField alloc] initWithFrame:CGRectMake(10,0, 3*frame.size.width/4 , frame.size.height)];
        self.tF.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15.0f];
        self.tF.placeholder = @"Loop tracks your news...";
        
<<<<<<< HEAD
        self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.tF.frame.size.width + 15, 0, frame.size.width - self.tF.frame.size.width -30, frame.size.height)];
        self.sendBtn.titleLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:17.0f];
=======
        self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.tV.frame.size.width + 15, 0, frame.size.width - self.tV.frame.size.width -30, frame.size.height-12)];
>>>>>>> origin/master
        [self.sendBtn setTitle:@"send" forState:UIControlStateNormal];
        [self.sendBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:35.0/255.0 blue:206.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        defaultFrame = self.frame;
        defaultTextViewFrame = self.tV.frame;
        
        [self addSubview:separatorView];
        [self addSubview:self.tF];
        [self addSubview:self.sendBtn];
        
        self.tF.delegate = self;
        [self setBackgroundColor:[UIColor whiteColor]];
<<<<<<< HEAD
=======
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
        previousHeigth = MIN_HEIGHT;
        textHeigth = 0;
>>>>>>> origin/master

    }
    
    return self;
}
<<<<<<< HEAD
=======
-(void) sendMsg {
    [self.tV endEditing:YES];
}

#pragma textView Delegate
-(void)textViewDidChange:(UITextView *)textView{

//    if (textHeigth < MAX_HEIGHT) {
        textHeigth = [self getLabelHeightFromString:textView.text];
//    }else{
//        textHeigth = MAX_HEIGHT;
//    }
   
    CGRect newTextViewFrame = [self.tV frame];
    CGRect newFrame = [self frame];
    
    NSLog(@"textHeigth %f",textHeigth);
    NSLog(@"previousHeigth %f",previousHeigth);
    NSLog(@"--------------");
    
    if ( textHeigth > previousHeigth && textHeigth < MAX_HEIGHT) {
        
        newTextViewFrame.size.height = textHeigth;
        newFrame.size.height = textHeigth;
        newFrame.origin.y =  newFrame.origin.y - (textHeigth-previousHeigth);

    }
    else if (textHeigth < previousHeigth && textHeigth > 56 && textHeigth < MAX_HEIGHT){
        
        newTextViewFrame.size.height = textHeigth;
        newFrame.size.height = textHeigth;
        newFrame.origin.y =  newFrame.origin.y + 23;
        
    }
    if ( MIN_HEIGHT < textHeigth && textHeigth != 108 ) {
        previousHeigth = textHeigth;
    }
    [UIView animateWithDuration:0.25 animations:^
     {
         [self.tV setFrame:newTextViewFrame];
         [self setFrame:newFrame];
     }];
    
}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText: (NSString *)text
//{
//    
//    NSLog(@"string lenght: %lu",(unsigned long)textView.text.length);
//
//    long length = textView.text.length;
//    
////    if ([text isEqualToString:@""] && length == 0) {
////        [self resetView];
////    }
//    
//    if([text isEqualToString:@"\n"]) // new line
//    {
//        [self updateTextFieldFrame:YES];
//    }else {
//        
//        if([text isEqualToString:@""]) // backspace
//        {
//            textView.selectedRange = range;
//            NSString *selectedText = [textView textInRange:[textView selectedTextRange]];
//            
//            if ([selectedText isEqualToString:@"\n"])  { // line change
//                [self updateTextFieldFrame:NO];
//            }
//        }
//    }
//
//    return YES;
//}

// get label height for post to make dynamic cell in ViewPostTVC
- (CGFloat)getLabelHeightFromString:( NSString*)inputText {
    
    CGSize constrainedSize = CGSizeMake(self.tV.frame.size.width, 9999);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15.0f], NSFontAttributeName,nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:inputText attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    if (requiredHeight.size.width > self.tV.frame.size.width - 30) {
        requiredHeight = CGRectMake(0,0, self.tV.frame.size.width - 30, requiredHeight.size.height);
    }
    
    return requiredHeight.size.height;
}

-(void) resetView{
    
    CGRect newTextViewFrame = defaultTextViewFrame;
    CGRect newFrame = defaultFrame;
    
    [UIView animateWithDuration:0.25 animations:^
     {
         [self.tV setFrame:defaultTextViewFrame];
         [self setFrame:defaultFrame];
     }];
}
-(void) updateTextFieldFrame:(BOOL) enlargeHeight{
    
    CGRect newTextViewFrame = [self.tV frame];
    CGRect newFrame = [self frame];
    
    if (enlargeHeight && self.tV.frame.size.height < MAX_HEIGHT){
        
        //TextView
        newTextViewFrame.size.height = self.tV.frame.size.height + GROWTH_SIZE;
        
        //TextView Container
        newFrame.size.height = self.frame.size.height + GROWTH_SIZE;
        newFrame.origin.y = self.frame.origin.y - GROWTH_SIZE;

    }else if (!enlargeHeight && self.tV.frame.size.height > MIN_HEIGHT){
        
        newTextViewFrame.size.height = self.tV.frame.size.height - GROWTH_SIZE;

        newFrame.size.height = self.frame.size.height - GROWTH_SIZE;
        newFrame.origin.y = self.frame.origin.y + GROWTH_SIZE;

    }
    
    [UIView animateWithDuration:0.25 animations:^
     {
         [self.tV setFrame:newTextViewFrame];
         [self setFrame:newFrame];
     }];
}

- (void) textViewDidBeginEditing:(UITextView*)textView {
    
}


#pragma mark Keyboard events
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
>>>>>>> origin/master

@end
