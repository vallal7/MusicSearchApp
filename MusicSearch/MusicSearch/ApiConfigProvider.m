//
//  ApiConfigProvider.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "ApiConfigProvider.h"

@implementation ApiConfigProvider

/**
 * @name configureTrackSearch
 * @propertyOf ApiConfigProvider
 * @param attributeArray 
 * @description
 * Retrieve the correct url and append the required parameters to it
 */
+(NSURL*)configureTrackSearch:(NSArray*)attributeArray {
    return [self appendStringWithParameters:attributeArray with:SearchTrackUrl];
}

/**
 * @name configureLyricsSearch
 * @propertyOf ApiConfigProvider
 * @param attributeArray
 * @description
 * Retrieve the correct url and append the required parameters to it
 */
+(NSURL*)configureLyricsSearch:(NSArray*)attributeArray {
    return [self appendStringWithParameters:attributeArray with:SearchLyricsUrl];
}

/**
 * @name appendStringWithParameters
 * @propertyOf ApiConfigProvider
 * @param attributeArray stringUrl
 * @description
 * Replace the predefined separator string with the input parameters for the service url
 */
+(NSURL*)appendStringWithParameters:(NSArray*)attributeArray with:(NSString*)stringUrl {
    @try {
        for (NSString *str in attributeArray){
            NSRange rOriginal = [stringUrl rangeOfString: URLParametersSeparator];
            // If the separator String exists, do the replacement
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
    // Encode the string and form a url out of it
    NSString *encodedString = [stringUrl stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    return [NSURL URLWithString:encodedString];

}

@end
