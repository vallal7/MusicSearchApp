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
    BOOL trackLyrics;
    NSString *lyricsString;
    void (^updateUIBlock)(LyricsModel *lyrics);
}
@end

@implementation SearchLyricsService

-(void)callLyricsService:(NSArray*)searchParameters callBack:(void (^)(LyricsModel *lyrics))updateUI {
    {
        NSURL *url = [ApiConfigProvider configureLyricsSearch:searchParameters];
        
        self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            updateUIBlock = updateUI;
            
            NSXMLParser *myParser = [[NSXMLParser alloc] initWithData:data];
            [myParser setDelegate:self];
            [myParser setShouldResolveExternalEntities: YES];
            [myParser parse];
        }];
        [self.dataTask resume];
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if([elementName caseInsensitiveCompare:XMLLyricsTag] == NSOrderedSame) {
        trackLyrics = true;
    } else {
        trackLyrics = false;
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName caseInsensitiveCompare:XMLLyricsTag] == NSOrderedSame) {
        trackLyrics = false;
        LyricsModel *lyrics = [[LyricsModel alloc]init];
        [lyrics parseData:lyricsString];
        updateUIBlock(lyrics);
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(trackLyrics) {
        if (lyricsString == nil){
            lyricsString = [[NSString alloc]init];
        }
        lyricsString = [lyricsString stringByAppendingString:string];
    }
}

@end
