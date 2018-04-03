//
//  AKServerManager.h
//  TestApiRequest
//
//  Created by Artem Kolyadin on 17.03.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//  I have reused my old class for requests to API

#import <Foundation/Foundation.h>

typedef void (^imageCompletionHandler)(BOOL success,
                                       UIImage *image,
                                       NSError *error);

@interface AKServerManager : NSObject

+(AKServerManager*) sharedManager;
+(void) requestImageWithURL:(NSURL *)url andCompletionHandler:(imageCompletionHandler)completionHandler;

-(void) getPublicTimelineOnSuccess:(void(^)(NSArray* statuses)) success
        onFailure:(void(^)(NSError* error))  failure;

@end
