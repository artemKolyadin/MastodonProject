//
//  AKServerManager.m
//  TestApiRequest
//
//  Created by Artem Kolyadin on 17.03.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//


#import "AFNetworking.h"
#import "AKServerManager.h"

@interface AKServerManager()
@property (strong,nonatomic) AFHTTPSessionManager* sessionManager;
@end
@implementation AKServerManager

+(AKServerManager*) sharedManager {
    static AKServerManager* manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[AKServerManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL* url = [NSURL URLWithString:@"https://mastodon.social/api/v1/"];
        self.sessionManager=[[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}


-(void) getPublicTimelineOnSuccess:(void (^)(NSArray *))success onFailure:(void (^)(NSError *))failure {
    
    NSString* get = @"timelines/public";
    [self.sessionManager GET:get parameters:nil progress:nil
                     success:^(NSURLSessionTask *task, id responseObject) {
                         if (success) {
                             success(responseObject);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                         if (failure) {
                             failure(error);
                         }
                     }];
}



+(void) requestImageWithURL:(NSURL *)url andCompletionHandler:(imageCompletionHandler)completionHandler
{
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:imageRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *connectionError) {
                               if (!connectionError) {
                                   UIImage *avatarImage = [UIImage imageWithData:data];
                                   completionHandler(YES, avatarImage, nil);
                               } else {
                                   completionHandler(NO, nil, connectionError);
                               }
                           }];
}

@end
