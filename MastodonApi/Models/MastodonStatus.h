//
//  MastodonCard.h
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MastodonAccount;
@interface MastodonStatus : NSObject

@property (strong, nonatomic) MastodonAccount* account;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *createDate;
@property (strong, nonatomic) NSMutableArray *attachments;
@property (assign, nonatomic) BOOL hasImageAttachment;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (BOOL)isEqual:(id)object;
- (NSString*) createTimeAgo;

@end
