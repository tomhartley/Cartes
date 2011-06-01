//
//  THCard.h
//  Cartes
//
//  Created by Tom Hartley on 24/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THRandom.h"

typedef enum {
	THCardSuitClubs = 0,
	THCardSuitDiamonds,
	THCardSuitHearts,
	THCardSuitSpades
} THCardSuit;

@interface THCard : NSObject <NSCoding> {
    THCardSuit suit;
	int rank; //1 for ace, going to 13 for king
	BOOL faceUp;
}
-(id)initWithRandomValue;
- (id)initWithSuit:(THCardSuit)theSuit rank:(int)theRank;

-(void)flip;

//NSCoder methods
- (id)initWithCoder:(NSCoder *)decoder;
- (void)encodeWithCoder:(NSCoder *)encoder;

@property (nonatomic,readonly) THCardSuit suit;
@property (nonatomic,readonly) int rank;
@property (nonatomic) BOOL faceUp;
@property (nonatomic,readonly) NSString *shortRank;
@property (nonatomic,readonly) NSString *longRank;
@property (nonatomic,readonly) NSString *shortSuit;
@property (nonatomic,readonly) NSString *longSuit;

@end