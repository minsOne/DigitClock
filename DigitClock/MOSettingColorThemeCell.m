//
//  MOSettingColorThemeCell.m
//  DigitClock
//
//  Created by minsOne on 2014. 3. 24..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOSettingColorThemeCell.h"
#import "MOBackgroundColor.h"

@interface MOSettingColorThemeCell ()

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *themeButtons;

@end

@implementation MOSettingColorThemeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setRoundedButton];
    }
    return self;
}

- (void)setRoundedButton
{
    NSInteger cnt = 0;
    NSInteger selectedColorIndex = [[MOBackgroundColor sharedInstance] bgColorIndex];
    
    for (UIButton *button in self.themeButtons) {
        [button.layer setCornerRadius:15.0f];
        [button.layer setMasksToBounds:YES];
        if (cnt++ == selectedColorIndex) {
            [button setAlpha:0.8f];
            
        } else {
            [button setAlpha:1.0f];
        }
    }
}

- (IBAction)selectBackground:(id)sender
{
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 1001:
            [[MOBackgroundColor sharedInstance] setBgColorIndex:0];
            break;
        case 1002:
            [[MOBackgroundColor sharedInstance] setBgColorIndex:1];
            break;
        case 1003:
            [[MOBackgroundColor sharedInstance] setBgColorIndex:2];
            break;
        case 1004:
            [[MOBackgroundColor sharedInstance] setBgColorIndex:3];
            break;
        case 1005:
            [[MOBackgroundColor sharedInstance] setBgColorIndex:4];
            break;
        case 1006:
            [[MOBackgroundColor sharedInstance] setBgColorIndex:5];
            break;
        case 1007:
            [[MOBackgroundColor sharedInstance] setBgColorIndex:6];
            break;
        case 1008:
            [[MOBackgroundColor sharedInstance] setBgColorIndex:7];
            break;
        default:
            break;
    }
    
    
    NSString *bgName = [NSString stringWithFormat:@"bg%ld", (long)[[MOBackgroundColor sharedInstance]bgColorIndex]];
    [[MOBackgroundColor sharedInstance]setBgColorName:bgName];
    
    if ([self.delegate respondsToSelector:@selector(selectedBackground)]) {
        [self.delegate selectedBackground];
    }
    
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];

}

@end
