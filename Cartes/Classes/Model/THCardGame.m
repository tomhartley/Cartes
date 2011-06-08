//
//  THCardGame.m
//  Cartes
//
//  Created by Tom Hartley on 24/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "THCardGame.h"
#import "TKAlertCenter.h"

@implementation THCardGame
@synthesize delegate;

-(id)initWithMaxPlayers:(NSInteger)max {
    if ((self = [super init])) {
        gameSession = [[GKSession alloc] initWithSessionID:SESSION_ID displayName:nil sessionMode:GKSessionModeServer];
        maxPlayers = max;
        gameSession.available = YES;
        gameSession.delegate = self;
        [gameSession setDataReceiveHandler:self withContext:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCardToAPlayer:) name:@"THSendCard" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminateSession:) name:@"UIApplicationWillTerminateNotification" object:nil];
        players = [[NSMutableDictionary alloc] init];
    }
        return self;
}

-(void)sendCardToAPlayer:(NSNotification *)notification{
    //A TEMPORARY HACK FOR TESTING
    [[[players allValues] objectAtIndex:0] sendCard:[[notification userInfo] objectForKey:@"Card"]];
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    //Probably should do something if they disconect, y'know?
    switch (state) {
        case GKPeerStateConnected:
        {
            //Create player object and add it to the dictionary
            THPlayer *player = [[THPlayer alloc] initWithSession:gameSession peerID:peerID location:[self getSuitableLocation]];
            [player autorelease];
            [players setValue:player forKey:peerID];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:[NSString stringWithFormat:@"%@ connected to game", [session displayNameForPeer:peerID]]];
            break;
        }
        case GKPeerStateDisconnected:
            [players removeObjectForKey:peerID];
             [[TKAlertCenter defaultCenter] postAlertWithMessage:[NSString stringWithFormat:@"%@ disconnected", [session displayNameForPeer:peerID]]];
            break;
        case GKPeerStateUnavailable:
            [players removeObjectForKey:peerID];
        default: 
            break;
    }
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
    int currentPlayers = [[session peersWithConnectionState:GKPeerStateConnected] count];
    if (currentPlayers<maxPlayers) {
        [session acceptConnectionFromPeer:peerID error:nil];        
    } else {
        [session denyConnectionFromPeer:peerID];
    }
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
    /*THPlayer *failPlayer = [players objectForKey:peerID];*/
    [[TKAlertCenter defaultCenter] postAlertWithMessage:[NSString stringWithFormat:@"%@ disconnected", [session displayNameForPeer:peerID]]];
    [players removeObjectForKey:peerID];
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
    //We're screwed, fix this later, innit
    //Fuuuuuu... should probably go into nuclear meltdown or something... at least inform the user I guess.
    [[TKAlertCenter defaultCenter] postAlertWithMessage:[NSString stringWithFormat:@"Critical error. We're all gonna die some day."]];
    [players removeAllObjects];
    
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
            [unarchiver autorelease];
            [delegate addCard:newCard fromLocation:[[players valueForKey:peer] location]];
            [newCard autorelease];
            [unarchiver finishDecoding];
        }
            break;
        default:
            //Shit I have no clue ATM :D
            return;
            break;
    }
}

-(THPlayer *)getPlayerWithLocation:(THPlayerLocation)loc {
    NSArray *list = [players allValues];

    for (THPlayer *player in list) {
        if (player.location == loc) {
            return player;
        }
    }
    return nil;
}

- (THPlayerLocation) getSuitableLocation {
    NSArray *list = [players allValues];
    switch ([list count]) {
        case 0:
            //Nice, no work!
            return THPlayerLocationNorth;
        case 1:
            //Opposite the only player
            return oppositeSide([(THPlayer *) [list objectAtIndex:0] location]);
        case 2:
            //If the two current players are opposite each other, location is between them. Otherwise its opposite the first player
            if (oppositeSide([(THPlayer *) [list objectAtIndex:0] location])==[(THPlayer *) [list objectAtIndex:1] location]) {
                return adjacentSide([(THPlayer *) [list objectAtIndex:0] location]);
            } else {
                return oppositeSide([(THPlayer *) [list objectAtIndex:0] location]);
            }
        case 3:
            //Last remaining location, more painful to code than I thought it might be :)
            {
                THPlayerLocation locs [4] = {THPlayerLocationNorth,THPlayerLocationEast,THPlayerLocationEast,THPlayerLocationWest};
                for (int curLoc = 0; curLoc<4; curLoc++) {
                    BOOL cont = YES;
                    for (int playerNumber = 0; playerNumber<3; playerNumber++) {
                        if (([(THPlayer *) [list objectAtIndex:playerNumber] location])==locs[curLoc]) {
                            cont = NO;
                            break;
                        }
                    }
                    if (cont) {
                        return locs[curLoc];
                    }
                }
            }
        default:
            //Still screwed
            break;
    }
    return THPlayerLocationNorth;
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
            //Oh fuck, screwed
            return 0;
    }
}

THPlayerLocation adjacentSide (THPlayerLocation location) {
    switch (location) {
        case THPlayerLocationNorth:
            return THPlayerLocationEast;
        case THPlayerLocationSouth:
            return THPlayerLocationEast;
        case THPlayerLocationEast:
            return THPlayerLocationNorth;
        case THPlayerLocationWest:
            return THPlayerLocationNorth;
        default:
            //Oh fuck, screwed
            return 0;
    }
}

- (void) terminateSession:(NSNotification *)notification {
    //EXTERMINATE, EXTERMINATE
    [gameSession disconnectFromAllPeers];
}

@end
