//
//  MOBackgroundColor.h
//  DigitClock
//
//  Created by minsOne on 2014. 3. 25..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOBackgroundColor : NSObject

@property (nonatomic) NSString *bgColorName;
@property (nonatomic) NSInteger bgColorIndex;

+ (MOBackgroundColor*)sharedInstance;

@end
