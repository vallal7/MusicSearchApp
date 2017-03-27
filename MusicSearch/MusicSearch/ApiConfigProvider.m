//
//  ApiConfigProvider.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "ApiConfigProvider.h"
#import "Constants.h"

@implementation ApiConfigProvider

+(NSURL*)configureTrackSearch:(NSArray*)attributeArray {
    return [self appendStringWithParameters:attributeArray with:SearchTrackUrl];
}

+(NSURL*)configureLyricsSearch:(NSArray*)attributeArray {
    return [self appendStringWithParameters:attributeArray with:SearchLyricsUrl];

}

+(NSURL*)appendStringWithParameters:(NSArray*)attributeArray with:(NSString*)stringUrl {
    for (NSString *str in attributeArray){
        NSRange rOriginal = [stringUrl rangeOfString: @"$"];
        if (NSNotFound != rOriginal.location) {
            stringUrl = [stringUrl
                        stringByReplacingCharactersInRange: rOriginal
                        withString:                         str];
        }        
    }
    NSString *encodedString = [stringUrl stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    return [NSURL URLWithString:encodedString];

}

@end
