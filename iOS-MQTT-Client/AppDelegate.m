/*
 Licensed Materials - Property of IBM
 
 © Copyright IBM Corporation 2014. All Rights Reserved.
 
 This licensed material is sample code intended to aid the licensee in the development of software for the Apple iOS and OS X platforms . This sample code is  provided only for education purposes and any use of this sample code to develop software requires the licensee obtain and comply with the license terms for the appropriate Apple SDK (Developer or Enterprise edition).  Subject to the previous conditions, the licensee may use, copy, and modify the sample code in any form without payment to IBM for the purposes of developing software for the Apple iOS and OS X platforms.
 
 Notwithstanding anything to the contrary, IBM PROVIDES THE SAMPLE SOURCE CODE ON AN "AS IS" BASIS AND IBM DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND ANY WARRANTY OR CONDITION OF NON-INFRINGEMENT. IBM SHALL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR ECONOMIC CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR OPERATION OF THE SAMPLE SOURCE CODE. IBM SHALL NOT BE LIABLE FOR LOSS OF, OR DAMAGE TO, DATA, OR FOR LOST PROFITS, BUSINESS REVENUE, GOODWILL, OR ANTICIPATED SAVINGS. IBM HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS OR MODIFICATIONS TO THE SAMPLE SOURCE CODE.
 */

#import "AppDelegate.h"
#import "Messenger.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.tabBar = (UITabBarController *)self.window.rootViewController;
    return YES;
}

- (void)switchToConnect
{
    NSLog(@"%s:%d", __func__, __LINE__);
    [self.tabBar setSelectedIndex:0];
}

- (void)switchToPublish
{
    // TODO: can't do this from a callback
    NSLog(@"%s:%d", __func__, __LINE__);
    [self.tabBar setSelectedIndex:1];
}

- (void)switchToSubscribe
{
    NSLog(@"%s:%d", __func__, __LINE__);
    [self.tabBar setSelectedIndex:2];
}

- (void)switchToLog
{
    NSLog(@"%s:%d", __func__, __LINE__);
    [self.tabBar setSelectedIndex:3];
}

- (void)clearLog
{
    Messenger *messenger = [Messenger sharedMessenger];
    [messenger clearLog];
    [self reloadLog];
}

- (void)reloadLog
{
    // must do this on the main thread, since we are updating the UI
    dispatch_async(dispatch_get_main_queue(), ^{
        Messenger *messenger = [Messenger sharedMessenger];
        NSString *badge = [NSString stringWithFormat:@"%lu", (unsigned long)[messenger.logMessages count]];
        if ([badge isEqualToString:@"0"]) {
            badge = nil;
        }
        self.logView.navigationController.tabBarItem.badgeValue = badge;
        
        [self.logView.tableView reloadData];
    });
}

- (void)updateConnectButton
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *currentTitle = [[[self connectView] connectButton] currentTitle];
        if ([currentTitle isEqualToString:@"Connect"]) {
            [[[self connectView] connectButton] setTitle:@"Disconnect" forState:UIControlStateNormal];
        } else {
            [[[self connectView] connectButton] setTitle:@"Connect" forState:UIControlStateNormal];
        }
    });
}

- (void)reloadSubscriptionList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.subListView reloadData];
    });
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
