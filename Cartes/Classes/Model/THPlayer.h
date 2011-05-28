//
//  THPlayer.h
//  Cartes
//
//  Created by Tom Hartley on 28/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THCard.h"
#import <GameKit/GameKit.h>

typedef enum {
    THMessageTypeCard,
    //THMessageTypeClearData,
    //THMessageType,
} THMessageType;


typedef enum {
    THPlayerLocationNorth,
    THPlayerLocationEast,
    THPlayerLocationSouth,
    THPlayerLocationWest,
} THPlayerLocation;

@interface THPlayer : NSObject {
    NSArray *currentDeck;
    NSString *peerID;
    GKSession *session;
    THPlayerLocation location;
}

@property (nonatomic,readonly) NSArray *currentDeck;
@property (nonatomic,readonly) NSString *peerID;
@property (nonatomic,readonly) THPlayerLocation *location;


-(id)initWithSession:(GKSession *)currentSession peerID:(NSString *)peerClientID location:(THPlayerLocation)side
-(void)sendCard:(THCard *)card;
-(void)resync;

@end
