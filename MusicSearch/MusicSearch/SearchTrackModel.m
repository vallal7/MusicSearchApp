//
//  TrackModel.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "SearchTrackModel.h"

@implementation SearchTrackModel


-(void)getAllTack{
    //make the service class call
}

-(void)parseData:(NSDictionary *)responseDict{
    self.trackName = [responseDict objectForKey:TrackNameDictKey];
    self.albumName = [responseDict objectForKey:AlbumNameDictKey];
    self.artistName = [responseDict objectForKey:ArtistNameDictKey];
    self.albumImageName = [responseDict objectForKey:AlbumImageDictKey];
}
@end
