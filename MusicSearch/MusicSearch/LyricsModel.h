//
//  LyricsModel.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/26/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricsModel : NSObject

@property(nonatomic,retain)NSString *trackName;
@property(nonatomic,retain)NSString *lyricsContent;
@property(nonatomic,retain)NSString *artistName;
@property(nonatomic,retain)NSString *url;
-(void)parseData:(NSString *)lyricsText;

@end
