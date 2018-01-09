//
//  LoginViewController.m
//  testingDataProtectionclasses
//
//  Created by Murphy on 11/06/17.
//  Copyright © 2017 Murphy. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "Utils.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize txtPassword;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doLogin:(id)sender {
    BOOL isJailbroken = [Utils isJailbroken];
    
    if (isJailbroken){
        NSLog(@"Jailbreak Detection: %s", isJailbroken ? "TRUE" :"FALSE" );
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Jailbreak Detected"
                                    message:@"This Device is Jailbroken ;)"
                                    preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        if ([self isLoginValid]) {
            [self performSegueWithIdentifier: @"startApp" sender: self];
        }
    }
}

- (BOOL)isLoginValid {
    NSString *password = self.txtPassword.text;
    if ([password isEqualToString:@"H4rdP4ssw0rd" ])
    {
        return YES;
    }
    return NO;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
