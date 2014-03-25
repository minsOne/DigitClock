//
//  MOBackgroundColor.m
//  DigitClock
//
//  Created by minsOne on 2014. 3. 25..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOBackgroundColor.h"

@interface MOBackgroundColor ()

@end

@implementation MOBackgroundColor

+ (MOBackgroundColor*)sharedInstance{
    __strong static id _sharedObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[MOBackgroundColor alloc] init];
    });
    
    return _sharedObject;
}

- (id)init {
    
    if (self = [super init]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.bgColorIndex = [defaults integerForKey:@"Theme"] ;
        
        if( self.bgColorIndex ) {
            [defaults setInteger:0 forKey:@"Theme"];
            [defaults synchronize];
            self.bgColorName = [NSString stringWithFormat:@"bg%d", self.bgColorIndex];
            
        } else {
            self.bgColorName = [NSString stringWithFormat:@"bg%d", self.bgColorIndex];
        }
    }
    return self;
}

@end
