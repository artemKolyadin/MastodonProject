//
//  TimeLineTableTableViewController.m
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//  You should run this application on iPhone 5/5s/SE only.
//  UI of some viewcontrollers is non-adaptive for other displays.

#import "TimeLineTableViewController.h"
#import "AKServerManager.h"
#import "MastodonStatus.h"
#import "AKCardCell.h"
#import "MediaViewController.h"
#import "MastodonAccount.h"

@interface TimeLineTableViewController ()

@end

@implementation TimeLineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusesArray=[NSMutableArray array];
    //for reloadData in Table after loading accountAvatar
    [MastodonAccount setVc:self];
    
    [self loadDataForTimeline];
    
    
    //update table data with pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:203.0f/255.0f green:140.0f/255.0f blue:78.0f/255.0f alpha:1];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(loadDataForTimeline)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) loadDataForTimeline {
    AKServerManager* manager =[AKServerManager sharedManager];
    [manager getPublicTimelineOnSuccess:^(NSArray *statuses) {
        for (NSDictionary* dictionary in statuses){
            MastodonStatus* status=[[MastodonStatus alloc] initWithDictionary:dictionary];
            BOOL isUnique=YES;
            for (MastodonStatus* temp in self.statusesArray)
            {
                if ([status isEqual:temp]){
                       isUnique=NO;
                       break;
                }
            }
            if (isUnique) {
            [self.statusesArray addObject:status];
            [self sortStatusesByCreateDate];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            }
        }
    } onFailure:^(NSError *error) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }];
}


-(void) sortStatusesByCreateDate {
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"createDate"
                                        ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
    self.statusesArray = [NSMutableArray arrayWithArray:[self.statusesArray
                                 sortedArrayUsingDescriptors:sortDescriptors]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier=@"Cell";
    AKCardCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[AKCardCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    MastodonStatus* status = [self.statusesArray objectAtIndex:indexPath.row];
    MastodonAccount* account = status.account;
    cell.userImage.image=account.avatarImage;
    cell.userName.text=account.displayName;
    cell.userLogin.text=[@"@" stringByAppendingString:account.userName];
    cell.cardContent.text=status.content;
    //try to dynamic resizing text in content label..
    cell.cardContent.numberOfLines=0;
    cell.cardContent.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.createdTime.text= [status createTimeAgo];
    if (!status.hasImageAttachment){
        cell.hasImage.text=@"";
    }
    else {
        cell.hasImage.textColor=[UIColor orangeColor];
        cell.hasImage.text=@"Tap to see an image";
    }

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MastodonStatus* status = [self.statusesArray objectAtIndex:indexPath.row];
    if (status.hasImageAttachment){
    MediaViewController* vc= [self.storyboard instantiateViewControllerWithIdentifier:@"MediaViewControllerID"];
    MastodonStatus* status = [self.statusesArray objectAtIndex:indexPath.row];
    vc.status=status;
    [self.navigationController pushViewController:vc animated:YES];
    }
    else {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}


@end
