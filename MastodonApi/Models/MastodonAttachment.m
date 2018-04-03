//
//  MastodonAttachments.m
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//

#import "MastodonAttachment.h"
#import "MastodonAccount.h"
#import <UIKit/UIKit.h>
static const NSString *kMastodonAttachmentMetaKey = @"meta";
static const NSString *kMastodonAttachmentMetaSmallKey = @"small";
static const NSString *kMastodonAttachmentMetaSmallWidthKey = @"width";
static const NSString *kMastodonAttachmentMetaSmallHeightKey = @"height";
static const NSString *kMastodonAttachmentPreviewImageUrlKey = @"preview_url";


@implementation MastodonAttachment

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        NSString* type = [dictionary objectForKey:@"type"];
        if ([type isEqualToString:@"image"]) {
        _isImage=YES;
        NSDictionary* meta = [dictionary objectForKey:kMastodonAttachmentMetaKey];
        NSDictionary* smallSizes = [meta objectForKey:kMastodonAttachmentMetaSmallKey];
        _width=[[smallSizes objectForKey:kMastodonAttachmentMetaSmallWidthKey] integerValue];
        _height=[[smallSizes objectForKey:kMastodonAttachmentMetaSmallHeightKey] integerValue];
        _imageUrl=[NSURL URLWithString:[dictionary objectForKey:kMastodonAttachmentPreviewImageUrlKey]];
        }
        else {
            _isImage=NO;
        }
    }
    return self;
}

@end
