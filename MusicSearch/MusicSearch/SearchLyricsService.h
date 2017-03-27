//
//  SearchLyricsService.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Service.h"
#import "LyricsModel.h"

@interface SearchLyricsService :Service<NSXMLParserDelegate>
-(void)callLyricsService:(NSArray*)searchParameters callBack:(void (^)(LyricsModel *lyrics))updateUI;

@end
