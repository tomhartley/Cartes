//
//  THPlayer.m
//  Cartes
//
//  Created by Tom Hartley on 28/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "THPlayer.h"


@implementation THPlayer
@synthesize peerID,location,displayName;

-(id)initWithSession:(GKSession *)currentSession peerID:(NSString *)peerClientID location:(THPlayerLocation)side {
    if ((self = [super init])) {
        session = [currentSession retain];
        peerID = [peerClientID retain];
        location = side;
        displayName = [[session displayNameForPeer:peerID] retain];
    }
    return self;
}

-(void)sendCard:(THCard *)card {
    NSMutableData *cardData = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:cardData];
    [card encodeWithCoder:archiver];
    [archiver finishEncoding];
    [archiver release];
    int temp = THMessageTypeCard;
    NSMutableData *dataToSend = [NSMutableData dataWithBytes:&temp length:sizeof(THMessageType)];
    [dataToSend appendData:cardData];
    [cardData release];
    [session sendDataToAllPeers:dataToSend withDataMode:GKSendDataReliable error:nil];
}

-(NSArray *)currentDeck {
    return currentDeck;
}

-(void)resync {
    //TODO: Not implemented yet...
}

-(void)dealloc {
    [displayName release];
    [session release];
    [peerID release];
    [super dealloc];
}

@end
