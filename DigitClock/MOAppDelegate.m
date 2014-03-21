//
//  MOAppDelegate.m
//  DigitClock
//
//  Created by minsOne on 2014. 3. 20..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOAppDelegate.h"

@interface MOAppDelegate ()

@property (nonatomic) CGFloat brightness;

@end

@implementation MOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self setScreenBrightness];
    // disable the idle timer
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self restoreScreenBrightness];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self setScreenBrightness];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self restoreScreenBrightness];
}

- (void)setScreenBrightness
{
    self.brightness = [[UIScreen mainScreen] brightness];
    [[UIScreen mainScreen] setBrightness:1.0f];
    NSLog(@"Brightness : %f", self.brightness);
}

- (void)restoreScreenBrightness
{
    [[UIScreen mainScreen] setBrightness:self.brightness];
        NSLog(@"Brightness : %f", self.brightness);
}

@end
