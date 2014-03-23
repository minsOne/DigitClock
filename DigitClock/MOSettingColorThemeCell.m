//
//  MOSettingColorThemeCell.m
//  DigitClock
//
//  Created by minsOne on 2014. 3. 24..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOSettingColorThemeCell.h"

@interface MOSettingColorThemeCell ()

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *themeButtons;

@end

@implementation MOSettingColorThemeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setRoundedButton
{
    for (UIButton *button in self.themeButtons) {
        [button.layer setCornerRadius:15.0f];
        [button.layer setMasksToBounds:YES];
    }
}

- (IBAction)selectBackground:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSString *selectedTheme = nil;
    switch (button.tag) {
        case 1001:
            selectedTheme = @"bg0";
            break;
        case 1002:
            selectedTheme = @"bg1";
            break;
        case 1003:
            selectedTheme = @"bg2";
            break;
        default:
            break;
    }
    if ([self.delegate respondsToSelector:@selector(selectedBackground:)]) {
        [self.delegate selectedBackground:selectedTheme];
    }

}

@end
