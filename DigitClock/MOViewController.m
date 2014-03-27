//
//  MOViewController.m
//  DigitClock
//
//  Created by minsOne on 2014. 3. 20..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOViewController.h"
#import "MOSettingViewController.h"
#import "MOBackgroundColor.h"

#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

#import "MOGAIChangeBGEvent.h"
#import "MOGAIInitBGEvent.h"
#import "MOGAIHeartBeatEvent.h"

@interface MOViewController () {
    NSTimer *timer;
    NSTimer *keepAliveTimer;
    CGPoint lastTranslation;
    MOGAIEvent *changeBGGAIEvent;
    MOGAIEvent *initBGGAIEvent;
    MOGAIEvent *heartBeatGAIEvent;
    MOGAIEvent *gaievent;
}

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *digitViews;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *colonViews;
@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *weekdayLabels;
@end

@implementation MOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setup];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(tick)
                                                userInfo:nil
                                                 repeats:YES];
    
    keepAliveTimer = [NSTimer scheduledTimerWithTimeInterval:KeepAliveTime
                                                      target:self 
                                                    selector:@selector(sendHeartBeat)
                                                    userInfo:nil
                                                     repeats:YES];
    
    [self tick];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.screenName = [[MOBackgroundColor sharedInstance]bgColorName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Initialize Digit Clock
/**
 *  initial Digit Clock
 */
- (void)setup
{
    [self initGAIEvent];
    [self initBackground];
    [self changeBackground];
    [self initDigitView];
    [self initColonView];
    [self initWeekdayLabel];
}

- (void)initGAIEvent
{
    changeBGGAIEvent = [[MOGAIChangeBGEvent alloc]init];
    heartBeatGAIEvent = [[MOGAIHeartBeatEvent alloc]init];
    initBGGAIEvent = [[MOGAIInitBGEvent alloc]init];
}

/**
 *  initial DigitView
 */
- (void)initDigitView
{
    UIImage *digits = [UIImage imageNamed:@"Digits"];
    for (UIView *view in self.digitViews) {
        [view.layer setContents:(__bridge id)digits.CGImage];
        [view.layer setContentsRect:CGRectMake(0, 0, 1.0f/11.0f, 1.0)];
        [view.layer setContentsGravity:kCAGravityResizeAspect];
        [view.layer setMagnificationFilter:kCAFilterNearest];
    }
}

/**
 *  initial ColonView
 */
- (void)initColonView
{
    UIImage *digits = [UIImage imageNamed:@"Digits"];
    for (UIView *view in self.colonViews) {
        [view.layer setContents:(__bridge id)digits.CGImage];
        [view.layer setContentsRect:CGRectMake(10.0f/11.0f, 0, 1.0f/11.0f, 1.0)];
        [view.layer setContentsGravity:kCAGravityResizeAspect];
        [view.layer setMagnificationFilter:kCAFilterNearest];
    }

}

/**
 *  initial WeekdayLabel
 */
- (void)initWeekdayLabel
{
    for (UILabel *weekday in self.weekdayLabels) {
        [weekday setAlpha:0.2];
    }
}

#pragma mark - Set Digit Clock View

/**
 *  Set Digit Number
 *
 *  @param digit Time Number
 *  @param view  showing View
 */
- (void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    [view.layer setContentsRect:CGRectMake(digit * 1.0f / 11.0f, 0, 1.0f/11.0f, 1.0f)];
}

/**
 *  Set Weekday
 *
 *  @param weekday Weekday
 */
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

/**
 * Set Colon
 */
- (void)setColon
{
    for (UIView *view in self.colonViews) {
        CGFloat alpha = [view alpha];
        if (alpha == 0.0f) {
            alpha = 1.0f;
        } else {
            alpha = 0.0f;
        }
        [view setAlpha:alpha];
    }
}

/**
 *  operating Digit Clock
 */
- (void)tick
{
    NSDateComponents *components = [self getDateComponents];
    
    [UIView animateWithDuration:1.0 animations:^{
        [self setDigit:components.hour / 10 forView:self.digitViews[0]];
        [self setDigit:components.hour % 10 forView:self.digitViews[1]];
        [self setDigit:components.minute / 10 forView:self.digitViews[2]];
        [self setDigit:components.minute % 10 forView:self.digitViews[3]];
        [self setDigit:components.second / 10 forView:self.digitViews[4]];
        [self setDigit:components.second % 10 forView:self.digitViews[5]];
        [self setColon];
        [self setWeekday:components.weekday];
    }];
}
/**
 *  change View Alpha from up down gesture
 *
 *  @param translation gesture Point
 */
- (void)changeViewAlpha:(CGPoint)translation
{
    CGFloat alpha = [self.view alpha];
    NSLog(@"View Alpha : %f", alpha);
    
    if ( lastTranslation.y > translation.y && alpha < 1.0f ) {
        [self.view setAlpha:alpha + 0.01f];
    } else if ( lastTranslation.y < translation.y && alpha >= 0.02f ) {
        [self.view setAlpha:alpha - 0.01f];
    }
    lastTranslation = translation;
}

/**
 *  chagne Background
 */
- (void)changeBackground
{
    NSString *bgName = [[MOBackgroundColor sharedInstance]bgColorName];
    
    UIImage *bg = [UIImage imageNamed:bgName];
    [self.view.layer setContents:(__bridge id)bg.CGImage];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[[MOBackgroundColor sharedInstance]bgColorIndex]  forKey:@"Theme"];
    [defaults synchronize];
    
    gaievent = changeBGGAIEvent;
    [gaievent sendEvent];
}

/**
 *  initialize background
 */
- (void)initBackground
{
    NSString *bgName = [[MOBackgroundColor sharedInstance]bgColorName];
    
    UIImage *bg = [UIImage imageNamed:bgName];
    [self.view.layer setContents:(__bridge id)bg.CGImage];
    
    gaievent = initBGGAIEvent;
    [gaievent sendEvent];
}

/**
 *  Send HeartHeat
 */
- (void)sendHeartBeat
{
    gaievent = heartBeatGAIEvent;
    [gaievent sendEvent];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MOSettingViewController *destViewController = [[[segue destinationViewController]viewControllers]objectAtIndex:0];
    destViewController.delegate = self;
}

/**
 *  display View Gesture
 *
 *  @param sender PanGesture Object
 */
- (IBAction)displayGestureForPanGestureRecognizer:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(translation));
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            lastTranslation = translation;
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        case UIGestureRecognizerStateChanged:
            [self changeViewAlpha:translation];
            break;
        case UIGestureRecognizerStateEnded:
            break;
        case UIGestureRecognizerStateFailed:
            break;
        case UIGestureRecognizerStatePossible:
            break;
        default:
            break;
    }
}

/**
 *  Return DateComponents
 *
 *  @return DateComponents
 */
- (NSDateComponents *)getDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    return components;
}

@end
