//
//  ViewController.m
//  Loop
//
//  Created by Adam Albarghouthi on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import "ViewController.h"
<<<<<<< HEAD
#import "TextCell.h"
=======
#import <Firebase/Firebase.h>
>>>>>>> origin/remo

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) Firebase *myRootRef;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(-35.5f, 0.0f, 0.0f, 0.0f);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = [UIScreen mainScreen].bounds.size.height/9;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
<<<<<<< HEAD
    [self.tableView registerClass:[TextCell class] forCellReuseIdentifier:@"textCell"];
=======
    _myRootRef = [[Firebase alloc] initWithUrl:@"https://loopapp.firebaseio.com"];
    
    [self queryFirebase];
>>>>>>> origin/remo
}

-(void) queryFirebase{
    
    // Read data and react to changes
    [_myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
}

-(void) sendMsg:(NSString*) message{
    
    // Create a reference to a Firebase database URL
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://loopapp.firebaseio.com"];
    // Write data to Firebase
    [myRootRef setValue:@"Do you have data? You'll love Firebase."];
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
