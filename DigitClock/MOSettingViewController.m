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
}

@property (nonatomic) NSArray *cellIdentifierArray;
@property (nonatomic) NSString *selectedTheme;

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
    }
    return self;
}

- (void)setup
{
    self.cellIdentifierArray = [[NSArray alloc]initWithObjects: @"ColorCellIdentifier",
                                @"MakerCellIdentifier",
                                @"VersionCellIdentifier",
                                nil];
    
    self.navigationItem.title = @"Digit Clock";
    
    
    
    [self initNib];
}

- (void)initNib
{
    UINib *colorThemeCellNib = [UINib nibWithNibName:@"MOSettingColorThemeCell" bundle:nil];
    UINib *makerCellNib = [UINib nibWithNibName:@"MOSettingMakerTableViewCell" bundle:nil];
    UINib *versionCellNib = [UINib nibWithNibName:@"MOSettingVersionTableViewCell" bundle:nil];
    
    [[self tableView] registerNib:colorThemeCellNib forCellReuseIdentifier:@"ColorCellIdentifier"];
    [[self tableView] registerNib:makerCellNib forCellReuseIdentifier:@"MakerCellIdentifier"];
    [[self tableView] registerNib:versionCellNib forCellReuseIdentifier:@"VersionCellIdentifier"];
}

- (void)initNavigation
{
    UIBarButtonItem *backBtn =[[UIBarButtonItem alloc]initWithTitle:@"완료"
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(dismissViewAction:)
                               ];
    [backBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor grayColor],
                                     NSForegroundColorAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:backBtn];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    
}

- (void)dismissViewAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@", [self.cellIdentifierArray objectAtIndex:indexPath.section]];
    
    if (indexPath.section == kThemeSectionIndex) {
        MOSettingColorThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell setRoundedButton];
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

        // Configure the cell...
        
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

-(void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

@end
