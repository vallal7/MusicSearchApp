//
//  SearchLyricsService.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "SearchLyricsService.h"
#import "ApiConfigProvider.h"

@interface SearchLyricsService ()
{
    // flag to track the lyrics xml while parsing
    BOOL trackLyrics;
    // the final constructed lyrics string
    NSString *lyricsString;
    // a copy of the callback block object, so as to trigger it in the parser delegate methods
    void (^updateUIBlock)(LyricsModel *lyrics);
}
@end

@implementation SearchLyricsService

/**
 * @name callLyricsService
 * @propertyOf SearchLyricsService
 * @param searchParameters updateUI
 * @description
 * Make the service call after configuring the URL
 * If response is valid, serialize the json data and parse it
 */
-(void)callLyricsService:(NSArray*)searchParameters callBack:(void (^)(LyricsModel *lyrics))updateUI {
    {
        NSURL *url = [ApiConfigProvider configureLyricsSearch:searchParameters];
        
        self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            updateUIBlock = updateUI;
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if(httpResponse.statusCode == 200) {
                NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:data];
                [myParser setDelegate:self];
                [myParser setShouldResolveExternalEntities: YES];
                [myParser parse];
            } else {
                // If response is invalid, handle the app accordingly
                LyricsModel *lyrics = [[LyricsModel alloc]init];
                [lyrics parseData:LyricsNotFoundString];
                updateUIBlock(lyrics);
            }
        }];
        [self.dataTask resume];
    }
}

#pragma mark - XML Parser Delegate methods

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    // Set the track lyrics flag when the current parsed element is Lyrics
    if([elementName caseInsensitiveCompare:XMLLyricsTag] == NSOrderedSame) {
        trackLyrics = true;
    } else {
        trackLyrics = false;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName caseInsensitiveCompare:XMLLyricsTag] == NSOrderedSame) {
        // As parsing of Lyrics XML Tag has ended, stop the track flag and trigger the callback with the updated object
        trackLyrics = false;
        LyricsModel *lyrics = [[LyricsModel alloc]init];
        [lyrics parseData:lyricsString];
        updateUIBlock(lyrics);
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // Capture the tag content when the track lyrics flag is true
    if(trackLyrics) {
        if (lyricsString == nil){
            lyricsString = [[NSString alloc]init];
        }
        lyricsString = [lyricsString stringByAppendingString:string];
    }
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Lyrics Service XML Parser failed");
}

@end
