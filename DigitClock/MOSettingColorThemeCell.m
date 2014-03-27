//
//  MOSettingColorThemeCell.m
//  DigitClock
//
//  Created by minsOne on 2014. 3. 24..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOSettingColorThemeCell.h"
#import "MOBackgroundColor.h"

@interface MOSettingColorThemeCell () {
    NSDictionary *backgroundMapping;
}

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *themeButtons;

@end

@implementation MOSettingColorThemeCell

#define kColorButtonCornerRadius 15.0f

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    backgroundMapping = @{@1001:@0,
                          @1002:@1,
                          @1003:@2,
                          @1004:@3,
                          @1005:@4,
                          @1006:@5,
                          @1007:@6,
                          @1008:@7,
                          };
    for (UIButton *button in self.themeButtons) {
        [button.layer setCornerRadius:kColorButtonCornerRadius];
        [button.layer setMasksToBounds:YES];
    }

}

- (IBAction)selectBackground:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSNumber *bgColorIndex = backgroundMapping[[NSNumber numberWithInteger:button.tag]];
    NSString *bgName = nil;
    
    if (bgColorIndex) {
        [[MOBackgroundColor sharedInstance] setBgColorIndex:[bgColorIndex integerValue]];
    }
    bgName = [NSString stringWithFormat:@"bg%ld", (long)[[MOBackgroundColor sharedInstance]bgColorIndex]];
    
    [[MOBackgroundColor sharedInstance]setBgColorName:bgName];
    
    if ([self.delegate respondsToSelector:@selector(selectedBackground)]) {
        [self.delegate selectedBackground];
    }
    
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];

}

@end
