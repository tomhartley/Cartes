//
//  Cartes.h
//  Cartes
//
//  Created by Tom Hartley on 31/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define SESSION_ID @"com.tmhrtly.Cartes"

typedef enum {
    THMessageTypeCard,
    THMessageTypeClearData,
    THMessageTypePause,
} THMessageType;


typedef enum {
    THPlayerLocationNorth,
    THPlayerLocationEast,
    THPlayerLocationSouth,
    THPlayerLocationWest,
} THPlayerLocation;
