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

#import "PublishViewController.h"
#import "Messenger.h"
#import "AppDelegate.h"

@interface PublishViewController ()
@property (weak, nonatomic) IBOutlet UITextField *topicInput;
@property (weak, nonatomic) IBOutlet UITextField *payloadInput;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;
@property (weak, nonatomic) IBOutlet UISwitch *retainedSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *qos;

@end

@implementation PublishViewController

- (IBAction)publishPressed:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
    
    NSString *topic = self.topicInput.text;
    NSString *payload = self.payloadInput.text;
    
    [[Messenger sharedMessenger] publish:topic payload:payload qos:(int)self.qos.selectedSegmentIndex retained:self.retainedSwitch.isOn];
}

- (IBAction)retainedChanged:(id)sender {
    NSLog(@"%s:%d - %@", __func__, __LINE__, sender);
    NSLog(@"retained changed to: %d", self.retainedSwitch.isOn);
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
    appDelegate.publishView = self;
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
