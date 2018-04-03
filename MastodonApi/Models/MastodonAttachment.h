//
//  MastodonAttachments.h
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@interface MastodonAttachment : NSObject

@property (assign, nonatomic) long width;
@property (assign, nonatomic) long height;
@property (strong, nonatomic) NSURL* imageUrl;
@property (strong, nonatomic) UIImage* image;
@property (assign, nonatomic) BOOL isImage;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
