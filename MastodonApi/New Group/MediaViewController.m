//
//  MediaViewController.m
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//

#import "MediaViewController.h"
#import "MastodonAttachment.h"
#import "AKServerManager.h"

@interface MediaViewController ()

@end

@implementation MediaViewController

- (void)viewDidLoad {
        [super viewDidLoad];
         MastodonAttachment* att= [self.status.attachments objectAtIndex:0];
         [AKServerManager requestImageWithURL:att.imageUrl andCompletionHandler:^(BOOL success, UIImage *attachmentImage, NSError *error) {
            if (!error){
                self.attachmentImage.image=attachmentImage;
                NSUInteger resizedWidth = attachmentImage.size.width;
                NSUInteger resizedHeight = attachmentImage.size.height;
                self.attachmentImage.frame = CGRectMake(0, 0, (CGFloat)resizedWidth, (CGFloat)resizedHeight);
                self.attachmentImage.center = self.attachmentImage.superview.center;
            }
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
