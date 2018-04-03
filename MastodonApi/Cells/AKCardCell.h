//
//  AKCardCell.h
//  MastodonApi
//
//  Created by Artem Kolyadin on 02.04.2018.
//  Copyright © 2018 Artem Kolyadin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hasImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userLogin;
@property (weak, nonatomic) IBOutlet UILabel *cardContent;
@property (weak, nonatomic) IBOutlet UILabel *createdTime;
@end
