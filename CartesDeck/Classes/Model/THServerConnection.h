//
//  THServerConnection.h
//  Cartes
//
//  Created by Tom Hartley on 31/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "Cartes.h"
#import "THCard.h"

@interface THServerConnection : NSObject <GKSessionDelegate> {
    GKSession *gameSession;
    BOOL connected;
    NSMutableArray *cards;
}

@property (nonatomic,retain,readonly) NSMutableArray *cards;

-(void)sendCard:(THCard *)card;
-(void)sendCardAtIndex:(int)index;

- (void) terminateSession:(NSNotification *)notification;

@end
