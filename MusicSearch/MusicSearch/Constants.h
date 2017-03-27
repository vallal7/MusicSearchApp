//
//  Constants.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define SearchTrackUrl @"https://itunes.apple.com/search?term=$"
#define SearchLyricsUrl @"http://lyrics.wikia.com/api.php?func=getSong&artist=$&song=$&fmt=xml"

#define LyricsScreenTitle @"Lyrics"
#define SearchScreenTitle @"Music Search"

#define SearchTableCellIdentifier @"CellIdentifier"
#define DetailSegueIdentifier @"detailSegue"

#define EnterValidSearchDataMessage @"Kindly enter valid data"
#define LyricsNotFoundString @"Not found"
#define LyricsNotFoundStringMesage @"Lyrics Not Found"
#define URLParametersSeparator @"$"

#define SearchTableViewCellNibName @"SearchTableViewCell"

#define TrackResultsDictKey @"results"
#define XMLLyricsTag @"lyrics"
#define TrackNameDictKey @"trackName"
#define ArtistNameDictKey @"artistName"
#define AlbumNameDictKey @"collectionName"
#define AlbumImageDictKey @"artworkUrl30"

#endif /* Constants_h */
