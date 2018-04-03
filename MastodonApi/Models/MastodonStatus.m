//
//  MastodonCard.m
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//

#import "MastodonStatus.h"
#import "MastodonAccount.h"
#import "MastodonAttachment.h"

static const NSString *kMastodonAccountKey = @"account";
static const NSString *kMastodonContentKey = @"content";
static const NSString *kMastodonCreatedAtKey = @"created_at";
static const NSString *kMastodonMediaAttachmentsKey = @"media_attachments";


@implementation MastodonStatus

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _hasImageAttachment=NO;
        _account = [[MastodonAccount alloc] initWithDictionary:
                    [dictionary objectForKey:kMastodonAccountKey]];
        _content = [dictionary objectForKey:kMastodonContentKey];
        _content = [self convertHTML:_content];
        _createDate = [self dateFromDateString:[dictionary objectForKey:kMastodonCreatedAtKey]];
        _attachments = [NSMutableArray array];
        NSArray* attachmentsArray = [dictionary objectForKey:kMastodonMediaAttachmentsKey];
        if (attachmentsArray.count) {
        for (NSDictionary* temp in attachmentsArray){
            MastodonAttachment* attach = [[MastodonAttachment alloc] initWithDictionary:temp];
            [_attachments addObject:attach];
            if (attach.isImage){
                _hasImageAttachment=YES;
            }
        }
        }
    }
    return self;
}

//calculate timeinterval between status create_at and current time
-(NSString*) createTimeAgo {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.createDate];
    timeInterval=timeInterval-10800; //difference in seconds between timezones
    NSDateComponentsFormatter* formatter = [[NSDateComponentsFormatter alloc] init];
    formatter.allowedUnits = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
    return [formatter stringFromTimeInterval:timeInterval];
}

// API returns status text with html tags
-(NSString *)convertHTML:(NSString *)html {
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}

// Converting formatted strings from the JSON into NSDate
- (NSDate *)dateFromDateString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
   
    return [dateFormatter dateFromString:dateString];
}


-(BOOL)isEqual:(id)object
{
    BOOL equal= [object isKindOfClass:[self class]]
    && [[(MastodonStatus *)object content] isEqualToString:self.content]
    && [[(MastodonStatus *)object createDate] isEqualToDate:self.createDate];
    return equal;
}


@end
