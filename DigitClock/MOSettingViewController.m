//
//  MOSettingViewController.m
//  DigitClock
//
//  Created by minsOne on 2014. 3. 24..
//  Copyright (c) 2014년 minsOne. All rights reserved.
//

#import "MOSettingViewController.h"
#import "MOSettingColorThemeCell.h"

@interface MOSettingViewController ()

@property (nonatomic) NSArray *cellIdentifierArray;

@property (nonatomic, weak) IBOutlet UIButton *theme1;
@property (nonatomic, weak) IBOutlet UIButton *theme2;
@property (nonatomic, weak) IBOutlet UIButton *theme3;

@property (nonatomic) NSString *selectedTheme;

@end

@implementation MOSettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cellIdentifierArray = [[NSArray alloc]initWithObjects:@"ColorCellIdentifier", @"MakerCellIdentifier", @"LicenseCellIdentifier", nil];
    UINib *nib = [UINib nibWithNibName:@"MOSettingColorThemeCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"ColorCellIdentifier"];
    
    self.selectedTheme = nil;
    
    self.navigationItem.title = @"Digit Clock";
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
        case 2:
            return 1;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@", [self.cellIdentifierArray objectAtIndex:indexPath.section]];

    if (indexPath.section == 0) {
        MOSettingColorThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell setRoundedButton];
        cell.delegate = self;
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        
        return cell;
    }
    

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"테마";
            break;
        case 1:
            return @"제작자";
            break;
        case 2:
            return @"Open Source License";
            break;
        default:
            return @"Title";
            break;
    }
}

- (void)selectedBackground:(NSString *)theme
{
    NSLog(@"Theme : %@", theme);
    self.selectedTheme = theme;
    
    if ([self.delegate respondsToSelector:@selector(changeBackground:)]) {
        [self.delegate changeBackground:theme];
    }
}

@end
