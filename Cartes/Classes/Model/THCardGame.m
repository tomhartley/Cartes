//
//  THCardGame.m
//  Cartes
//
//  Created by Tom Hartley on 24/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "THCardGame.h"


@implementation THCardGame

-(void)initWithMaxPlayers:(NSInteger)max {
    gameSession = [[GKSession alloc] initWithSessionID:@"com.tmhrtly.Cartes" displayName:nil sessionMode:GKSessionModeServer];
    maxPlayers = max;
    gameSession.available = YES;
    gameSession.delegate = self;
    [gameSession setDataReceiveHandler:self withContext:nil];
}


- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
    int currentPlayers = [[session peersWithConnectionState:GKPeerStateConnected] count];
    if (currentPlayers<maxPlayers) {
        [session acceptConnectionFromPeer:peerID error:nil];
        //Create player object and add it to the dictionary
        THPlayer *player = [[THPlayer alloc] initWithSession:gameSession peerID:peerID location:[self getSuitableLocation]];
        
    } else {
        [session denyConnectionFromPeer:peerID];
    }
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
    THPlayer *failPlayer = [players objectForKey:peerID];
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
    //We're screwed
}

- (THPlayerLocation) getSuitableLocation {
    NSArray *list = [players allValues];
    switch ([list count]) {
        case 0:
            //Nice, no work!
            return THPlayerLocationNorth;
            break;
        case 1:
            
        default:
            break;
    }

}

THPlayerLocation oppositeSide (THPlayerLocation location) {
    switch (location) {
        case THPlayerLocationNorth:
            return THPlayerLocationSouth;
        case THPlayerLocationSouth:
            return THPlayerLocationNorth;
        case THPlayerLocationEast:
            return THPlayerLocationWest;
        case THPlayerLocationWest:
            return THPlayerLocationEast;
        default:
            //Oh fuck
            return 0;
    }
}

@end
