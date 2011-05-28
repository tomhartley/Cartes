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
    NSDictionary *players; //Maps from a peerID to a THPlayer
    int maxPlayers;
}

-(void)initWithMaxPlayers:(NSInteger)max;
- (THPlayerLocation) getSuitableLocation;
@end
