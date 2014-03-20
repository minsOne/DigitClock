//
//  MOViewController.m
//  DigitClock
//
//  Created by minsOne on 2014. 3. 20..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOViewController.h"
//#import <QuartzCore/QuartzCore.h>

@interface MOViewController ()

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *digitViews;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *colonViews;
@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *weekdayLabels;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) IBOutlet UIView *clockView;
@end

@implementation MOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    UIImage *bg = [UIImage imageNamed:@"bg"];
    UIImage *digits = [UIImage imageNamed:@"Digits"];
    
    [self.view.layer setContents:(__bridge id)bg.CGImage];
    
    for (UIView *view in self.digitViews) {
        [view.layer setContents:(__bridge id)digits.CGImage];
        [view.layer setContentsRect:CGRectMake(0, 0, 1.0f/11.0f, 1.0)];
        [view.layer setContentsGravity:kCAGravityResizeAspect];
        [view.layer setMagnificationFilter:kCAFilterNearest];
    }
    for (UIView *view in self.colonViews) {
        [view.layer setContents:(__bridge id)digits.CGImage];
        [view.layer setContentsRect:CGRectMake(10.0f/11.0f, 0, 1.0f/11.0f, 1.0)];
        [view.layer setContentsGravity:kCAGravityResizeAspect];
        [view.layer setMagnificationFilter:kCAFilterNearest];
    }
    for (UILabel *weekday in self.weekdayLabels) {
        [weekday setAlpha:0.2];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 
                                                  target:self
                                                selector:@selector(tick) 
                                                userInfo:nil
                                                 repeats:YES];
    [self tick];
}
- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    [view.layer setContentsRect:CGRectMake(digit * 1.0f / 11.0f, 0, 1.0f/11.0f, 1.0f)];
}
- (void)animateColon
{
    for (UIView *view in self.colonViews) {
        CGFloat alpha = [view alpha];
        if (alpha == 0.0f) {
            alpha = 1.0f;
        } else {
            alpha = 0.0f;
        }
//        [UIView animateWithDuration:1.0f animations:^{
            [view setAlpha:alpha];
//        }];
    }
}

- (void)setWeekday:(NSInteger)weekday
{
    for (UILabel *weekdayLabel in self.weekdayLabels) {
        if (self.weekdayLabels[weekday-1] == weekdayLabel) {
            [self.weekdayLabels[weekday-1] setAlpha:1.0f];
        } else {
            [weekdayLabel setAlpha:0.2f];
        }
    }
}

- (void)tick
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
//    NSLog(@"%d %d %d %d %d %d", components.hour,components.minute, components.second, components.month, components.day );
    NSLog(@"Hour : %d", components.hour);
    NSLog(@"minute : %d", components.minute);
    NSLog(@"second : %d", components.second);
    NSLog(@"month : %d", components.month);
    NSLog(@"day : %d", components.day);
    NSLog(@"week : %d", components.week);
    NSLog(@"weekday : %d", components.weekday);
    
    [UIView animateWithDuration:1.0 animations:^{
        [self setDigit:components.hour / 10 forView:self.digitViews[0]];
        [self setDigit:components.hour % 10 forView:self.digitViews[1]];
        [self setDigit:components.minute / 10 forView:self.digitViews[2]];
        [self setDigit:components.minute % 10 forView:self.digitViews[3]];
        [self setDigit:components.second / 10 forView:self.digitViews[4]];
        [self setDigit:components.second % 10 forView:self.digitViews[5]];
        [self animateColon];
        [self setWeekday:components.weekday];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
