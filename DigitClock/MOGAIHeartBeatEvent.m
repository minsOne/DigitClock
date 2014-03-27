//
//  MOGAISendHeartBeatEvent.m
//  DigitClock
//
//  Created by edudev on 2014. 3. 27..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOGAIHeartBeatEvent.h"

@implementation MOGAIHeartBeatEvent

- (void)sendEvent{
    id<GAITracker> tracker= [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"app"
                                                          action:@"HeartBeat"
                                                           label:nil
                                                           value:nil]
                   build]];
}

@end
