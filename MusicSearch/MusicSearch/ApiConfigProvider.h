//
//  ApiConfigProvider.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiConfigProvider : NSObject

+(NSURL*)configureTrackSearch:(NSArray*)attributeArray;
+(NSURL*)configureLyricsSearch:(NSArray*)attributeArray;

@end
