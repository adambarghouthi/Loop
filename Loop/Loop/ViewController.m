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
    self.tableView.estimatedRowHeight = [UIScreen mainScreen].bounds.size.height/9;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TextCell class] forCellReuseIdentifier:@"textCell"];
    _msgTextView = [[textView alloc] initWithFrame:CGRectMake(0, height-50, width, height/16)];
    [self.view addSubview:_msgTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.height/9;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextCell *cell = (TextCell *)[tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    [cell.logoImage setImage:[UIImage imageNamed:@"adam"]];
    cell.contentField.text = @"News here.asdasdsaasd asdasdasd asda sd asdsa dasas d asd ";
    
    return cell;
}

@end
