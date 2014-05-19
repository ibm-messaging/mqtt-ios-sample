/*******************************************************************************
 * Copyright (c) 2014 IBM Corp.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * and Eclipse Distribution License v1.0 which accompany this distribution.
 *
 * The Eclipse Public License is available at
 *   http://www.eclipse.org/legal/epl-v10.html
 * and the Eclipse Distribution License is available at
 *   http://www.eclipse.org/org/documents/edl-v10.php.
 *
 * Contributors:
 *    Mike Robertson - initial contribution
 *******************************************************************************/

#import <UIKit/UIKit.h>
#import "ConnectViewController.h"
#import "PublishViewController.h"
#import "SubscribeViewController.h"
#import "LogViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) UITabBarController *tabBar;
@property (weak, nonatomic) ConnectViewController *connectView;
@property (weak, nonatomic) PublishViewController *publishView;
@property (weak, nonatomic) SubscribeViewController *subscribeView;
@property (weak, nonatomic) LogViewController *logView;
@property (weak, nonatomic) UITableView *subListView;

- (void)switchToConnect;
- (void)switchToPublish;
- (void)switchToSubscribe;
- (void)switchToLog;
- (void)clearLog;
- (void)reloadLog;
- (void)updateConnectButton;
- (void)reloadSubscriptionList;

@end
