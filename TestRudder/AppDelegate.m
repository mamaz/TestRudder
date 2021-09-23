//
//  AppDelegate.m
//  TestRudder
//
//  Created by mamazo on 12/09/21.
//  Copyright © 2021 mamazo. All rights reserved.
//

#import "AppDelegate.h"
#import <Rudder/Rudder.h>
#import "Rudder/RSElementCache.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    NSURL *dataPlaneUrl = [NSURL URLWithString:@"https://dataplane.url"];
    NSString *writeKey = @"...";
    NSString *newUUID = [NSUUID UUID].UUIDString;

    [RSClient setAnonymousIdOnce:newUUID];
    [RSLogger logInfo:[NSString stringWithFormat:@">>>>> NEW UUID: %@",newUUID]];

    RSConfigBuilder *builder = [[RSConfigBuilder alloc]init];
    [builder withDataPlaneURL:dataPlaneUrl];
    [builder withControlPlaneURL:dataPlaneUrl];
    [builder withLoglevel:RSLogLevelDebug];
    [RSClient getInstance:writeKey config:[builder build]];

    // We use [RSElementCache getAnonymousId] since it is the right way
    // of getting the real anonymous id from RSPreferenceManager
    NSString *fetchedId = [RSElementCache getAnonymousId];
    [RSLogger logInfo:[NSString stringWithFormat:@">>>>> SET UUID: %@",fetchedId]];

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
