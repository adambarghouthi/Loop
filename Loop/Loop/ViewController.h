//
//  ViewController.h
//  Loop
//
//  Created by Adam Albarghouthi on 2015-11-14.
//  Copyright © 2015 Loop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) Firebase *myRootRef;
@property (strong, nonatomic) Firebase *postingRef;

@end

