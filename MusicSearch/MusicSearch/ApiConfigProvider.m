//
//  ApiConfigProvider.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "ApiConfigProvider.h"

@implementation ApiConfigProvider

+(NSURL*)configureTrackSearch:(NSArray*)attributeArray {
    return [self appendStringWithParameters:attributeArray with:SearchTrackUrl];
}

+(NSURL*)configureLyricsSearch:(NSArray*)attributeArray {
    return [self appendStringWithParameters:attributeArray with:SearchLyricsUrl];

}

+(NSURL*)appendStringWithParameters:(NSArray*)attributeArray with:(NSString*)stringUrl {
    @try {
        for (NSString *str in attributeArray){
            NSRange rOriginal = [stringUrl rangeOfString: URLParametersSeparator];
            if (NSNotFound != rOriginal.location) {
                stringUrl = [stringUrl
                             stringByReplacingCharactersInRange: rOriginal
                             withString:                         str];
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"Strings Append Exception -%@",exception);
    } @finally {
        NSLog(@"Strings Append Complete");
    }
    NSString *encodedString = [stringUrl stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    return [NSURL URLWithString:encodedString];

}

@end
