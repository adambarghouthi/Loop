//
//  ViewController.m
//  Loop
//
//  Created by Adam Albarghouthi on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import "ViewController.h"
#import "TextCell.h"
#import "textView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) textView *msgTextView;
@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // firebase integration
    self.array = [NSMutableArray array];

    self.myRootRef = [[Firebase alloc] initWithUrl:@"https://sweltering-fire-9217.firebaseio.com/"];
    self.postingRef = [[Firebase alloc] initWithUrl:@"https://hackharvard.firebaseio.com/"];
    
    [self.myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {

        NSLog(@"Observation: %@ -> %@", snapshot.key, snapshot.value);
        [self.array removeAllObjects];

        for (FDataSnapshot *parent in snapshot.children) {
            for (FDataSnapshot *child in parent.children) {
                if ([child.key isEqualToString:@"tweet"]) {
                    [self.array addObject:child.value];
                    NSLog(@"%@",child.value);
                }
            }
        }
        
        [self.tableView reloadData];
    }];
    /////////
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
        
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-27.5f, 0.0f, 0.0f, 0.0f);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TextCell class] forCellReuseIdentifier:@"textCell"];
    
    _msgTextView = [[textView alloc] initWithFrame:CGRectMake(0, height-40, width, 40)];
    [_msgTextView.sendBtn addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_msgTextView];
    
    [self registerForKeyboardNotifications];
}

-(void)sendMsg {
    [self.view endEditing:YES];
    if ([_msgTextView.tF.text isEqualToString:@""]) {
        return;
    }
    
    Firebase *child = [self.postingRef childByAutoId];
    NSDictionary *dict = @{@"task":_msgTextView.tF.text};
    [child setValue:dict];
    _msgTextView.tF.text = @"";
}

- (void)registerForKeyboardNotifications
{
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWillShow:)
    //                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

// get label height for post to make dynamic cell in ViewPostTVC
- (CGFloat)getLabelHeightFromTextAt:(NSIndexPath *)indexPath {
    
    CGSize constrainedSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 30.0f, 9999);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15.0f], NSFontAttributeName,nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.array[indexPath.row] attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    if (requiredHeight.size.width > [UIScreen mainScreen].bounds.size.width - 30) {
        requiredHeight = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width - 30, requiredHeight.size.height);
    }
    
    //    self.reviewHeight = requiredHeight.size.height;
    
    return requiredHeight.size.height;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self getLabelHeightFromTextAt:indexPath] + [UIScreen mainScreen].bounds.size.width/7 + 45.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextCell *cell = (TextCell *)[tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    [cell.userImg setTitle:@"∞" forState:UIControlStateNormal];

    ///////////////////
    // update frames according to textView height
    CGRect newLabelFrame = CGRectMake(15, CGRectGetMaxY(cell.userImg.frame) + 10.0f, [UIScreen mainScreen].bounds.size.width - 30.0f, [self getLabelHeightFromTextAt:indexPath]+20.0f);
    cell.textView.frame = newLabelFrame; // review update
    cell.view.frame = CGRectMake(7.5, 7.5, [UIScreen mainScreen].bounds.size.width-15, [self getLabelHeightFromTextAt:indexPath] + [UIScreen mainScreen].bounds.size.width/7 + 30.0f);
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell.view.bounds];
    cell.view.layer.masksToBounds = NO;
    cell.view.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.view.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    cell.view.layer.shadowOpacity = 0.08f;
    cell.view.layer.shadowRadius = 5.0f;
    cell.view.layer.shadowPath = shadowPath.CGPath;
    ///////////////////
    
    if (self.array.count != 0) {
        cell.textView.text = self.array[indexPath.row];    
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_msgTextView.tF endEditing:YES];
}

-(void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary* notificationInfo = [notification userInfo];
    
    CGRect keyboardFrame = [[notificationInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:[[notificationInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]
                          delay:0
                        options:[[notificationInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]
                     animations:^{
                         
                         UIEdgeInsets contentInsets = UIEdgeInsetsMake(27.5, 0.0, keyboardFrame.size.height, 0.0);
                         self.tableView.contentInset = contentInsets;
                         self.tableView.scrollIndicatorInsets = contentInsets;
                         
                         CGRect frame = self.msgTextView.frame;
                         frame.origin.y = keyboardFrame.origin.y - frame.size.height;
                         self.msgTextView.frame = frame;
                         
                     } completion:nil];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(27.5, 0.0f, 0.0f, 0.0f);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}

//#pragma mark Touch events
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    [_msgTextView.tV resignFirstResponder];
//}

@end
