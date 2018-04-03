//
//  MastodonAccount.h
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AKServerManager.h"

@class TimeLineTableViewController;
@interface MastodonAccount : NSObject

@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSString* displayName;
@property (strong, nonatomic) NSURL* avatarURL;
@property (strong, nonatomic) UIImage* avatarImage;
@property (class, strong, nonatomic) TimeLineTableViewController* vc;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
