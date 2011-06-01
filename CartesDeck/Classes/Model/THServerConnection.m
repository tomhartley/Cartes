//
//  THServerConnection.m
//  Cartes
//
//  Created by Tom Hartley on 31/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "THServerConnection.h"
@implementation THServerConnection

-(id)init {
    if ((self = [super init])) {
        gameSession = [[GKSession alloc] initWithSessionID:SESSION_ID displayName:nil sessionMode:GKSessionModeClient];
        gameSession.delegate = self;
        gameSession.available = YES;
        //[gameSession setDataReceiveHandler:self withContext:nil];
        connected = NO;
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
    [gameSession sendDataToAllPeers:dataToSend withDataMode:GKSendDataReliable error:nil];
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    switch (state) {
        case GKPeerStateAvailable:
            if (!connected) {
                [gameSession connectToPeer:peerID withTimeout:3];
                //Well, I'm trying to connect...
                NSLog(@"Attempting to connect!");
            }
            break;
        case GKPeerStateConnected:
            //Nice!
            connected = YES;
            NSLog(@"Connected to server!!! Epic winning :D");
        case GKPeerStateDisconnected:
            connected = NO;
        default:
            break;
    }
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
    //Now I'm just confused... I mean, like WUT... I'm a client. Not a server. I'm so afraid...
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
    //Eh, fuck it, we CBA to reconnect atm
    connected = NO;
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
    //Why so much fail?
    connected = NO;
}

@end
