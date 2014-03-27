//
//  MOGAISendHeartBeatEvent.h
//  DigitClock
//
//  Created by edudev on 2014. 3. 27..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOGAIEvent.h"

@interface MOGAIHeartBeatEvent : MOGAIEvent

- (void)sendEvent;

@end
