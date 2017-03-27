//
//  LyricsModel.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/26/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "LyricsModel.h"

@implementation LyricsModel

-(void)parseData:(NSString *)lyricsText{
    // If no Lyrics data was found, update the lyrics model object accordingly
    if([lyricsText caseInsensitiveCompare:LyricsNotFoundString] == NSOrderedSame) {
        self.lyricsContent = LyricsNotFoundStringMesage;
    } else {
        self.lyricsContent = lyricsText;
    }
}

@end
