//
//  SearchTableViewCell.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *trackName;
@property (nonatomic, weak) IBOutlet UILabel *artistName;
@property (nonatomic, weak) IBOutlet UILabel *albumName;
@property (nonatomic, weak) IBOutlet UIImageView *albumImage;

@end
