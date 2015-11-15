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
@property (strong, nonatomic) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
//
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-27.5f, 0.0f, 0.0f, 0.0f);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TextCell class] forCellReuseIdentifier:@"textCell"];
    _msgTextView = [[textView alloc] initWithFrame:CGRectMake(0, height-40, width, height/12)];
    [self.view addSubview:_msgTextView];
    
    self.array = @[@"Lorem Ipsum.", @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.", @"At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti.", @"At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti.At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti.", @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self getLabelHeightFromTextAt:indexPath] + [UIScreen mainScreen].bounds.size.width/7 + 45.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextCell *cell = (TextCell *)[tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    [cell.userImg setImage:[UIImage imageNamed:@"adam"]];

    ///////////////////
    // update frames according to textView height
    CGRect newLabelFrame = CGRectMake(15, CGRectGetMaxY(cell.userImg.frame) + 10.0f, [UIScreen mainScreen].bounds.size.width - 30.0f, [self getLabelHeightFromTextAt:indexPath]+20.0f);
    cell.textView.frame = newLabelFrame; // review update
    cell.view.frame = CGRectMake(7.5, 7.5, [UIScreen mainScreen].bounds.size.width-15, [self getLabelHeightFromTextAt:indexPath] + [UIScreen mainScreen].bounds.size.width/7 + 30.0f);
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell.view.bounds];
    cell.view.layer.masksToBounds = NO;
    cell.view.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.view.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    cell.view.layer.shadowOpacity = 0.1f;
    cell.view.layer.shadowRadius = 5.0f;
    cell.view.layer.shadowPath = shadowPath.CGPath;
    ///////////////////
    
    cell.textView.text = self.array[indexPath.row];

    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_msgTextView.tV endEditing:YES];
}

//#pragma mark Touch events
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    [_msgTextView.tV resignFirstResponder];
//}

@end
