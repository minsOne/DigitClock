//
//  MOGAIInitBGSendState.m
//  DigitClock
//
//  Created by edudev on 2014. 3. 27..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOGAIInitBGEvent.h"

@implementation MOGAIInitBGEvent

- (void)sendEvent{
        NSLog(@"%s", __PRETTY_FUNCTION__);
    id<GAITracker> tracker= [[GAI sharedInstance] defaultTracker];
    NSString *bgName = [[MOBackgroundColor sharedInstance]bgColorName];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Theme"
                                                          action:GAInitBackgroundAction
                                                           label:bgName
                                                           value:nil]
                   build]];
}

@end
