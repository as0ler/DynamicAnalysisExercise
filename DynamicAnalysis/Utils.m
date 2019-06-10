//
//  Created by Murphy on 11/06/17.
//  Copyright © 2017 Murphy. All rights reserved.
//


#import "Utils.h"


@interface Utils ()

@end

@implementation Utils

+ (BOOL)isJailbroken
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:@"/bin/bash"]) {
        return YES;
    } else if ([fileManager fileExistsAtPath:@"/bin/ls"]) {
        return YES;
    }
    
    return NO;
}

@end
