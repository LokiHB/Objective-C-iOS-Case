//
//  AppDelegate.m
//  Objective-C-iOS
//
//  Created by bys on 20/03/2018.
//  Copyright © 2018 bys. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end
@import AppCenter;
@import AppCenterAnalytics;
@import AppCenterCrashes;
@import AppCenterPush;
@interface AppDelegate ()<MSPushDelegate>
@end
@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MSPush setDelegate:self];
    [MSAppCenter start:@"e16b6efc-d513-4b88-b6e8-a737c8013dcd" withServices:
        @[
          [MSAnalytics class],
          [MSCrashes class],
          [MSPush class]
         ]
    ];
    
    NSDictionary *properties = @{@"Category" : @"Music", @"FileName" : @"favorite.avi"};
    [MSAnalytics trackEvent:@"Video clicked" withProperties: properties];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)push:(MSPush *)push didReceivePushNotification:(MSPushNotification *)pushNotification {
    NSString *title = pushNotification.title ?: @"";
    NSString *message = pushNotification.message;
    NSMutableString *customData = nil;
    for (NSString *key in pushNotification.customData) {
        ([customData length] == 0) ? customData = [NSMutableString new] : [customData appendString:@", "];
        [customData appendFormat:@"%@: %@", key, [pushNotification.customData objectForKey:key]];
    }
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateBackground) {
        NSLog(@"Notification received in background, title: \"%@\", message: \"%@\", custom data: \"%@\"", title, message,
              customData);
    } else {
        message = [NSString stringWithFormat:@"%@%@%@", (message ? message : @""), (message && customData ? @"\n" : @""),
                   (customData ? customData : @"")];
        
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        
        // Show the alert controller.
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}
@end
