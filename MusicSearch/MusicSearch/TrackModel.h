//
//  TrackModel.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TrackModel : NSObject
-(void)parseData:(NSDictionary *)responseDict;
@property(nonatomic,retain)NSString *trackName;
@property(nonatomic,retain)NSString *albumName;
@property(nonatomic,retain)NSString *artistName;
@property(nonatomic,retain)NSString *albumImageName;
@property(nonatomic,retain)UIImage *albumImage;

@end
