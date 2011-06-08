//
//  THServerConnection.m
//  Cartes
//
//  Created by Tom Hartley on 31/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "THServerConnection.h"
#import "TKAlertCenter.h"

@implementation THServerConnection
@synthesize cards;

-(id)init {
    if ((self = [super init])) {
        gameSession = [[GKSession alloc] initWithSessionID:SESSION_ID displayName:nil sessionMode:GKSessionModeClient];
        gameSession.delegate = self;
        gameSession.available = YES;
        [gameSession setDataReceiveHandler:self withContext:nil];
        connected = NO;
        cards = [[NSMutableArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminateSession:) name:@"UIApplicationWillTerminateNotification" object:nil];
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

-(void)sendCardAtIndex:(int)index {
    THCard *cardToSend = [cards objectAtIndex:index];
    [self sendCard:cardToSend];
    [[self mutableArrayValueForKey:@"cards"] removeObjectAtIndex:index];
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
            [[TKAlertCenter defaultCenter] postAlertWithMessage:[NSString stringWithFormat:@"Connected to %@", [session displayNameForPeer:peerID]]];
        case GKPeerStateDisconnected:
            connected = NO;
             [[TKAlertCenter defaultCenter] postAlertWithMessage:[NSString stringWithFormat:@"Disconnected from %@", [session displayNameForPeer:peerID]]];
        default:
            break;
    }
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
    THMessageType messageType;
    [data getBytes:&messageType range:NSMakeRange(0, sizeof(THMessageType))];
    
    switch (messageType) {
        case THMessageTypeCard:
        {
            NSData *cardData = [data subdataWithRange:NSMakeRange(sizeof(THMessageType), [data length]-sizeof(THMessageType))];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:cardData];
            //NSLog(@"%@",unarchiver);
            THCard *newCard = [[THCard alloc] initWithCoder:unarchiver];
            [unarchiver finishDecoding];
            [unarchiver autorelease];
            [[self mutableArrayValueForKey:@"cards"] addObject:newCard];
            [newCard autorelease];
        }
            break;
        default:
            //Shit I have no clue ATM :D
            return;
            break;
    }
}


- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
    //Now I'm just confused... I mean, like WUT... I'm a client. Not a server. I'm so afraid...
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
    //Eh, fuck it, we CBA to reconnect atm
    [[TKAlertCenter defaultCenter] postAlertWithMessage:[NSString stringWithFormat:@"Disconnected from server", [session displayNameForPeer:peerID]]];
    connected = NO;
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
    //Why so much fail?
    connected = NO;
    [[TKAlertCenter defaultCenter] postAlertWithMessage:[NSString stringWithFormat:@"Disconnected from server"]];
}

- (void) terminateSession:(NSNotification *)notification {
    [gameSession disconnectFromAllPeers];
    //EXTERMINATE, EXTERMINATE
}


@end
