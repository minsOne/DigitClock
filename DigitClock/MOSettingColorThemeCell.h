//
//  MOSettingColorThemeCell.h
//  DigitClock
//
//  Created by minsOne on 2014. 3. 24..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MOSettingColorThemeCellDelegate <NSObject>

- (void)selectedBackground:(NSString *)theme;

@end

@interface MOSettingColorThemeCell : UITableViewCell

@property (weak, nonatomic) id <MOSettingColorThemeCellDelegate> delegate;

- (void)setRoundedButton;

@end
