//
//  MediaViewController.h
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MastodonStatus.h"
@interface MediaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *attachmentImage;
@property (strong,nonatomic) MastodonStatus* status;
@end
