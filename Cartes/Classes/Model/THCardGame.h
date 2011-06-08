//
//  THCardGame.h
//  Cartes
//
//  Created by Tom Hartley on 24/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "THCard.h"
#import "THPlayer.h"

@interface THCardGame : NSObject <GKSessionDelegate>{
    GKSession *gameSession;
    NSMutableDictionary *players; //Maps from a peerID to a THPlayer
    int maxPlayers;
    id delegate; //Will document later... sure, keep believing
}

@property (nonatomic, assign) id delegate;

-(id)initWithMaxPlayers:(NSInteger)max;
- (THPlayerLocation) getSuitableLocation;
-(THPlayer *)getPlayerWithLocation:(THPlayerLocation)loc;
-(void)sendCardToAPlayer:(NSNotification *)notification;

THPlayerLocation oppositeSide (THPlayerLocation location);
THPlayerLocation adjacentSide (THPlayerLocation location);
- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context;
- (void) terminateSession:(NSNotification *)notification;
@end
