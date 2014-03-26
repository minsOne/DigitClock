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



@interface MOSettingViewController ()

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
    self.cellIdentifierArray = [[NSArray alloc]initWithObjects:
                                @"ColorCellIdentifier",
                                @"MakerCellIdentifier",
                                @"VersionCellIdentifier",
                                nil];
    
    self.navigationItem.title = @"Digit Clock";
    
    UINib *colorThemeCellNib = [UINib nibWithNibName:@"MOSettingColorThemeCell" bundle:nil];
    UINib *makerCellNib = [UINib nibWithNibName:@"MOSettingMakerTableViewCell" bundle:nil];
    UINib *versionCellNib = [UINib nibWithNibName:@"MOSettingVersionTableViewCell" bundle:nil];
    
    [[self tableView] registerNib:colorThemeCellNib forCellReuseIdentifier:@"ColorCellIdentifier"];
    [[self tableView] registerNib:makerCellNib forCellReuseIdentifier:@"MakerCellIdentifier"];
    [[self tableView] registerNib:versionCellNib forCellReuseIdentifier:@"VersionCellIdentifier"];
    
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
    switch (section) {
        case kThemeSectionIndex:
            return kThemeSectionCount;
            break;
        case kMakerSectionIndex:
            return kMakerSectionCount;
        case kVersionSectionIndex:
            return kVersionSectionCount;
        default:
            return 1;
            break;
    }
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
        
        switch (indexPath.row) {
            case 0:
                [cell.title setText:@"Developer : Ahn Jung Min"];
                break;
            case 1:
                [cell.title setText:@"Designer : Joo Sung Hyun"];
                break;
            default:
                break;
        }
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
    switch (section)
    {
        case 0:
            return @"Theme";
            break;
        case 1:
            return @"Maker";
            break;
        case 2:
            return @"Version";
            break;
        default:
            return @"Title";
            break;
    }
}

- (void)selectedBackground
{
    if ([self.delegate respondsToSelector:@selector(changeBackground:)]) {
        [self.delegate changeBackground:GAChangeBackgroundAction];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

@end
