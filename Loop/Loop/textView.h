//
//  textView.h
//  Loop
//
//  Created by Adam Albarghouthi on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface textView : UIView<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *tF;
@property (strong, nonatomic) UIButton *sendBtn;

@end
