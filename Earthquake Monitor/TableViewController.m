//
//  TableViewController.m
//  Earthquake Monitor
//
//  Created by Daramony on 4/19/16.
//  Copyright © 2016 MobileAppsCompany. All rights reserved.
//

#import "TableViewController.h"
#import "EQService.h"
#import "TableViewCell.h"
#import "DetailViewController.h"

#define DETAIL_SEGUE @"showDetail"
#define CELL_IDENTIFIER @"cell"

@interface TableViewController ()

@property (strong, nonatomic) NSMutableArray *dataList;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = [[NSMutableArray alloc] init];
    [self fetchData];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(fetchData)];
    self.navigationItem.rightBarButtonItem = refreshButton;
}

-(void)fetchData {
    [self.dataList removeAllObjects];
    [self.tableView reloadData];
    
    EQService *eqService = [[EQService alloc] init];
    [eqService getFeedPastHourWithCompletion:^(NSString *title, NSMutableArray *dataList, BOOL status) {
        if (status) {
            self.dataList = dataList;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                self.navigationItem.title = title;
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    EQSummaryEntity *eqSummaryEntity = self.dataList[indexPath.row];
    cell.eqSummaryEntity = eqSummaryEntity;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:DETAIL_SEGUE sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:DETAIL_SEGUE]) {
        DetailViewController *detailViewControoler = [segue destinationViewController];
        EQSummaryEntity *eqSummaryEntity = self.dataList[[[self.tableView indexPathForSelectedRow] row]];
        detailViewControoler.eqSummaryEntity = eqSummaryEntity;
    }
}


@end
