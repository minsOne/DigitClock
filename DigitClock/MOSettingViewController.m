//
//  MOSettingViewController.m
//  DigitClock
//
//  Created by minsOne on 2014. 3. 24..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOSettingViewController.h"
#import "MOSettingColorThemeCell.h"
#import "MOSettingMakerTableViewCell.h"
#import "MOSettingVersionTableViewCell.h"



@interface MOSettingViewController () {
    NSDictionary *cellCountMapping;
    NSDictionary *makerNameMapping;
    NSDictionary *sectionHeaderMapping;
    NSArray *cellIdentifierArray;
}

@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneItem;

@end

@implementation MOSettingViewController

#define kSectionCount 3

#define kThemeSectionIndex 0
#define kMakerSectionIndex 1
#define kVersionSectionIndex 2

#define kThemeSectionCount 1
#define kMakerSectionCount 2
#define kVersionSectionCount 1

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.view setAlpha:1.0f];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initMapping];
    [self initNib];
}

-(void)viewWillAppear:(BOOL)animated {
    if (IS_IPHONE) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    if (IS_IPHONE) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialize Cell Value
- (void)initNib
{
    cellIdentifierArray = @[
                            @{@"ColorCellIdentifier": [UINib nibWithNibName:@"MOSettingColorThemeCell" bundle:nil]
                              },
                            @{@"MakerCellIdentifier": [UINib nibWithNibName:@"MOSettingMakerTableViewCell" bundle:nil]
                              },
                            @{@"VersionCellIdentifier": [UINib nibWithNibName:@"MOSettingVersionTableViewCell" bundle:nil]
                              }
                            ];
    
    for (NSInteger i = 0; i < [cellIdentifierArray count] ; i++) {
        NSString *cellIdentifier = [[cellIdentifierArray[i] allKeys]objectAtIndex:0];
        [[self tableView] registerNib:[cellIdentifierArray[i] objectForKey:cellIdentifier]
               forCellReuseIdentifier:cellIdentifier];
    }
}

- (void)initMapping
{
    if(!cellCountMapping) {
        cellCountMapping = @{
                             @kThemeSectionIndex : @kThemeSectionCount,
                              @kMakerSectionIndex : @kMakerSectionCount,
                              @kVersionSectionIndex : @kVersionSectionCount,
                              };
    }
    
    if (!makerNameMapping) {
        makerNameMapping = @{
                             @0: @"Developer : Ahn Jung Min",
                             @1: @"Designer : Joo Sung Hyun"
                             };
    }
    
    if (!sectionHeaderMapping) {
        sectionHeaderMapping = @{
                                 @0 : @"Theme",
                                 @1 : @"Maker",
                                 @2 : @"Version",
                                 };
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSNumber *count = cellCountMapping[[NSNumber numberWithInteger:section]];
    return count ? [count integerValue] : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@", [[[cellIdentifierArray objectAtIndex:indexPath.section]allKeys] objectAtIndex:0] ];
    
    if (indexPath.section == kThemeSectionIndex) {
        MOSettingColorThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        
        return cell;
    }
    else if (indexPath.section == kMakerSectionIndex) {
        MOSettingMakerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        NSString *title = makerNameMapping[[NSNumber numberWithInteger:indexPath.row]];
        
        title ? [cell.title setText:title] : [cell.title setText:@"Default"];
        return cell;
    }
    
    else {
        MOSettingVersionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        [cell.version setText:[NSString stringWithFormat:@"Version : %@", version]];
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleForHeader = sectionHeaderMapping[[NSNumber numberWithInteger:section]];
    return titleForHeader ? titleForHeader : @"Title";
}



- (void)selectedBackground
{
    if ([self.delegate respondsToSelector:@selector(changeBackground)]) {
        [self.delegate changeBackground];
    }
}

- (IBAction)dismissViewAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


@end
