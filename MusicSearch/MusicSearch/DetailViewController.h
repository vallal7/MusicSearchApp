//
//  DetailViewController.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic,retain)NSString *trackName;
@property (nonatomic,retain)NSString *albumName;
@property (nonatomic,retain)NSString *artistName;
@property (nonatomic,retain)UIImage *trackImage;

@property(nonatomic, weak) IBOutlet UILabel *trackNameLabel;
@property(nonatomic, weak) IBOutlet UILabel *artistNameLabel;
@property(nonatomic, weak) IBOutlet UILabel *albumNameLabel;
@property(nonatomic, weak) IBOutlet UIImageView *trackImageView;

@end
