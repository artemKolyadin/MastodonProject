//
//  MastodonAccount.m
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//

#import "MastodonAccount.h"
#import "TimeLineTableViewController.h"
#import "AKServerManager.h"

static const NSString *kMastodonUserNameKey = @"username";
static const NSString *kMastodonDisplayNameKey = @"display_name";
static const NSString *kMastodonAvatarURLKey = @"avatar";

static TimeLineTableViewController *_vc = nil;

@implementation MastodonAccount

+ (TimeLineTableViewController*) vc {
    if (_vc == nil) {
        _vc = [[TimeLineTableViewController alloc] init];
    }
    return _vc;
}

+ (void)setVc:(TimeLineTableViewController *)vc{
    _vc=vc;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _userName = [dictionary objectForKey:kMastodonUserNameKey];
        _displayName = [dictionary objectForKey:kMastodonDisplayNameKey];
        _avatarURL = [NSURL URLWithString:[dictionary objectForKey:kMastodonAvatarURLKey]];
        [AKServerManager requestImageWithURL:_avatarURL andCompletionHandler:^(BOOL success, UIImage *avatarImage, NSError *error) {
            if (success) {
                _avatarImage=avatarImage;
                [_vc.tableView reloadData];
            }
        }];
    }
    return self;
}


@end
