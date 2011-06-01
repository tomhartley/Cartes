//
//  THPlayer.m
//  Cartes
//
//  Created by Tom Hartley on 28/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "THPlayer.h"


@implementation THPlayer
@synthesize peerID,location;

-(id)initWithSession:(GKSession *)currentSession peerID:(NSString *)peerClientID location:(THPlayerLocation)side {
    if ((self = [super init])) {
        session = currentSession;
        peerID = peerClientID;
        location = side;
    }
    return self;
}

-(void)sendCard:(THCard *)card {
    NSData *cardData = [NSKeyedArchiver archivedDataWithRootObject:card];
    NSMutableData *dataToSend = [NSMutableData dataWithBytes:(int)THMessageTypeCard length:sizeof(THMessageType)];
    [dataToSend appendData:cardData];
    [session sendData:dataToSend toPeers:[NSArray arrayWithObject:peerID] withDataMode:GKSendDataReliable error:nil];
}

-(NSArray *)currentDeck {
    return currentDeck;
}

-(void)resync {
    //TODO: Not implemented yet...
}

@end
