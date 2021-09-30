//
//  ViewController.m
//  TestRudder
//
//  Created by mamazo on 12/09/21.
//  Copyright © 2021 mamazo. All rights reserved.
//

#import "ViewController.h"
#import <Rudder/Rudder.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[RSClient sharedInstance] identify:@"terserah" traits:@{
        @"regisId": @"lalalallallalalallallallalalla"
    }];
}

- (IBAction)logout:(id)sender {
    NSLog(@"LOGOUT >>>");
    
    // We should resetting anonymous id before resetting
    NSString *newUUID =[NSUUID UUID].UUIDString;
    [RSClient setAnonymousId: newUUID];

    
    [[RSClient sharedInstance] reset];
    
    NSLog(@">>>>> UUID SET ON LOGOUT %@", newUUID);
}

@end
