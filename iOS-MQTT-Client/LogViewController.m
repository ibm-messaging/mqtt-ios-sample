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

#import "LogViewController.h"
#import "LogMessage.h"
#import "Messenger.h"
#import "AppDelegate.h"

@interface LogViewController ()

@end

@implementation LogViewController

- (IBAction)clearPressed:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate clearLog];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        appDelegate.logView = self;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Messenger *messenger = [Messenger sharedMessenger];
    return [messenger.logMessages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LogPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Messenger *messenger = [Messenger sharedMessenger];
    LogMessage *message = [messenger.logMessages objectAtIndex:indexPath.row];
    cell.textLabel.text = message.data;
    cell.detailTextLabel.text = message.timestamp;
    
    if ([message.type isEqualToString:@"Action"]) {
        [cell.imageView setImage:[UIImage imageNamed:@"glyphicons_003_user.png"]];
    } else if ([message.type isEqualToString:@"Publish"]) {
        [cell.imageView setImage:[UIImage imageNamed:@"glyphicons_213_up_arrow.png"]];
    } else if ([message.type isEqualToString:@"Subscribe"]) {
        [cell.imageView setImage:[UIImage imageNamed:@"glyphicons_212_down_arrow.png"]];
    }
    return cell;
}

@end
