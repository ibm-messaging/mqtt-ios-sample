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

#import "SubscribeViewController.h"
#import "Messenger.h"
#import "Subscription.h"
#import "AppDelegate.h"

@interface SubscribeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *topicInput;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet UITableView *subListTable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *qos;

@end

@implementation SubscribeViewController

- (IBAction)subscribePressed:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
    
    NSString *topic = self.topicInput.text;
    
    [[Messenger sharedMessenger] subscribe:topic qos:(int)self.qos.selectedSegmentIndex];
}

- (IBAction)qosSegmentChanged:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
    NSLog(@"qos changed to: %ld", (long)self.qos.selectedSegmentIndex);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"%s:%d", __func__, __LINE__);
        
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.subscribeView = self;
    appDelegate.subListView = self.subListTable;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Text Field delegate implementations
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    textField.backgroundColor = [UIColor whiteColor];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear:");
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn:");
    if (textField.tag == 1) {
        UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:2];
        [passwordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

# pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    Messenger *messenger = [Messenger sharedMessenger];
    return [messenger.subscriptionData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SubscriptionPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Messenger *messenger = [Messenger sharedMessenger];
    Subscription *subscription = [messenger.subscriptionData objectAtIndex:indexPath.row];
    cell.textLabel.text = subscription.topicFilter;
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Messenger *messenger = [Messenger sharedMessenger];
        Subscription *sub = [messenger.subscriptionData objectAtIndex:indexPath.row];
        
        [messenger unsubscribe:sub.topicFilter];
        
        [self.subListTable deselectRowAtIndexPath:indexPath animated:TRUE];

        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate reloadSubscriptionList];
    }
}

@end
