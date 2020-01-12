//  Created by Murphy on 20/03/16.
//  Copyright © 2016 Murphy. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController: UIViewController
- (IBAction)connectHTTP:(id)sender {
    NSString * const SERVERCOMMUNICATION_USER_URL = @"https://pwn.0xmurphy.me/secret";

    NSString *username = @"master";
    NSString *password = @"Y3t4NotherP4ss";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SERVERCOMMUNICATION_USER_URL]];

    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *parameterString =[NSString stringWithFormat:@"user=%@&password=%@", username, password];
    NSData *postData = [parameterString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {}
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Success"
                                message:@"HTTP sent successfully."
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    NSLog(@"HTTP Sent");
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createFile:(id)sender {

    NSLog(@"Creating File With DataProtection -> ");
    NSFileManager *filemgr;
    filemgr = [NSFileManager defaultManager];
    NSString *str = @"Here another secret stored in the filesystem. => p4ssw0rd!\n";
    NSData *content = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString *tmpFile = [tmpDirectory stringByAppendingPathComponent:@"newfile.txt"];
    
    if (![filemgr createFileAtPath:tmpFile contents: content attributes: [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey]])
    {
        NSLog(@"Error was code: %d - message: %s", errno, strerror(errno));
    }
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Success"
                                message:@"File created successfully."
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];

    NSLog(@"File created");
}

- (IBAction)createKeychainData:(id)sender {
    NSLog(@"Creating Keychain entry With DataProtection -> ");
    //Let's create an empty mutable dictionary:
    NSMutableDictionary *keychainItem = [NSMutableDictionary dictionary];
    
    NSString *username = @"administrator";
    NSString *password = @"secret_password";
    NSString *website = @"http://www.example.com";
    
    //Populate it with the data and the attributes we want to use.
    
    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassInternetPassword; // We specify what kind of keychain item this is.
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleWhenUnlocked; // This item can only be accessed when the user unlocks the device.
    keychainItem[(__bridge id)kSecAttrServer] = website;
    keychainItem[(__bridge id)kSecAttrAccount] = username;
    
    //Check if this keychain item already exists.
    
    if(SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, NULL) == noErr)
    {
        
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"The Item Already Exists"
                                    message:@"Updated instead."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else
    {
        keychainItem[(__bridge id)kSecValueData] = [password dataUsingEncoding:NSUTF8StringEncoding]; //Our password
        
        OSStatus sts = SecItemAdd((__bridge CFDictionaryRef)keychainItem, NULL);
        NSLog(@"Error Code: %d", (int)sts);
        
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Success"
                                    message:@"Keychain item created successfully."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (IBAction)updateKeychainData:(id)sender {
    //Let's create an empty mutable dictionary:
    NSMutableDictionary *keychainItem = [NSMutableDictionary dictionary];
    
    NSString *username = @"administrator";
    NSString *password = @"secret_password_updated";
    NSString *website = @"http://www.example.com";
    
    //Populate it with the data and the attributes we want to use.
    
    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassInternetPassword; // We specify what kind of keychain item this is.
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleWhenUnlocked; // This item can only be accessed when the user unlocks the device.
    keychainItem[(__bridge id)kSecAttrServer] = website;
    keychainItem[(__bridge id)kSecAttrAccount] = username;
    
    //Check if this keychain item already exists.
    
    if(SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, NULL) == noErr)
    {
        //The item was found.
        
        //We can update the keychain item.
        
        NSMutableDictionary *attributesToUpdate = [NSMutableDictionary dictionary];
        attributesToUpdate[(__bridge id)kSecValueData] = [password dataUsingEncoding:NSUTF8StringEncoding];
        
        OSStatus sts = SecItemUpdate((__bridge CFDictionaryRef)keychainItem, (__bridge CFDictionaryRef)attributesToUpdate);
        NSLog(@"Error Code: %d", (int)sts);
       
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Success"
                                    message:@"Keychain item updated successfully."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else
    {

        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Item Doesn't Exist."
                                    message:@"The item you want to update doesn't exist."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)deleteKeychainData:(id)sender {
    //Let's create an empty mutable dictionary:
    NSMutableDictionary *keychainItem = [NSMutableDictionary dictionary];
    
    NSString *username = @"administrator";
    NSString *website = @"http://www.example.com";
    
    //Populate it with the data and the attributes we want to use.
    
    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassInternetPassword; // We specify what kind of keychain item this is.
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleWhenUnlocked; // This item can only be accessed when the user unlocks the device.
    keychainItem[(__bridge id)kSecAttrServer] = website;
    keychainItem[(__bridge id)kSecAttrAccount] = username;
    
    //Check if this keychain item already exists.
    
    if(SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, NULL) == noErr)
    {
        OSStatus sts = SecItemDelete((__bridge CFDictionaryRef)keychainItem);
        NSLog(@"Error Code: %d", (int)sts);
        
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Success"
                                    message:@"Keychain item deleted successfully."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else
    {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"he Item Doesn't Exist."
                                    message:@"The item doesn't exist. It may have already been deleted."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];

    }
}

@end
