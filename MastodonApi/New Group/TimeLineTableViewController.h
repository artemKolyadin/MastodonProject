//
//  TimeLineTableTableViewController.h
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//  You should run this application on iPhone 5/5s/SE only.
//  UI of some viewcontrollers is non-adaptive for other displays.

#import <UIKit/UIKit.h>

@interface TimeLineTableViewController : UITableViewController 

@property (strong,nonatomic) NSMutableArray* statusesArray;

@end
