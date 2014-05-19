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

#import "ConnectViewController.h"
#import "Messenger.h"
#import "AppDelegate.h"
#include <stdlib.h>

@implementation ConnectViewController

+ (NSString*) uniqueId {
    return [NSString stringWithFormat: @"MQTTTest.%d", arc4random_uniform(10000)];
}

+ (NSArray*) parseCommaList:(NSString*)field {
    return [field componentsSeparatedByString:@","];
}

- (IBAction)connectPressed:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);

    if ([[[self connectButton] currentTitle]  isEqual:@"Connect"]) {
        // Connect button text will be "Disconnect" while the client is connected.
        NSArray *servers = [ConnectViewController parseCommaList:self.serverInput.text];
        NSArray *ports = [ConnectViewController parseCommaList:self.portInput.text];
    
        // Only generate a new unique clientID if this client doesn't already have one.
        NSString *clientID = [[Messenger sharedMessenger] clientID];
        if (clientID == NULL) {
            clientID = [ConnectViewController uniqueId];
            [[Messenger sharedMessenger] setClientID:clientID];
        }
        [[Messenger sharedMessenger] connectWithHosts:servers ports:ports clientId:clientID cleanSession:self.cleanSession.isOn];
    
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate switchToPublish];
    } else {
        [[Messenger sharedMessenger] disconnectWithTimeout:5];
    }
}

- (IBAction)cleanSessionChanged:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
    NSLog(@"cleanSession changed to: %d", self.cleanSession.isOn);
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
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.connectView = self;
    
    NSLog(@"%s:%d", __func__, __LINE__);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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

@end
