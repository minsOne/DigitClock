//
//  MOSettingViewController.h
//  DigitClock
//
//  Created by minsOne on 2014. 3. 24..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOSettingColorThemeCell.h"

@protocol MOSettingViewControllerDelegate <NSObject>

- (void)changeBackground;

@end

@interface MOSettingViewController : UITableViewController<MOSettingColorThemeCellDelegate>

@property (weak, nonatomic) id <MOSettingViewControllerDelegate> delegate;

-(void)selectedBackground;

@end
