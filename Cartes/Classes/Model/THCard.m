//
//  THCard.m
//  Cartes
//
//  Created by Tom Hartley on 24/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "THCard.h"


@implementation THCard
@synthesize suit,rank,faceUp;

-(NSString *)shortRank {
	if (rank <11 && rank > 1) {
		return [NSString stringWithFormat:@"%d",rank];
	} else {
		switch (rank) {
			case 1:
				return @"A";
				break;
			case 11:
				return @"J";
				break;
			case 12:
				return @"Q";
				break;
			case 13:
				return @"K";
				break;
			default:
				return @"?";
				break;
		}
	}
}

-(NSString *)longRank {
	if (rank <11 && rank > 1) {
		return [NSString stringWithFormat:@"%d",rank];
	} else {
		switch (rank) {
			case 1:
				return @"Ace";
				break;
			case 11:
				return @"Jack";
				break;
			case 12:
				return @"Queen";
				break;
			case 13:
				return @"King";
				break;
			default:
				return @"?";
				break;
		}
	}
}

-(NSString *)shortSuit {
	switch (self.suit) {
		case THCardSuitClubs:
			return @"♣";
			break;
		case THCardSuitDiamonds:
			return @"♦";
			break;
		case THCardSuitHearts:
			return @"♥";
			break;
		case THCardSuitSpades:
			return @"♠";
			break;
		default:
			return @"?";
			break;
	}
}

-(NSString *)longSuit {
	switch (self.suit) {
		case THCardSuitClubs:
			return @"Clubs";
			break;
		case THCardSuitDiamonds:
			return @"Diamonds";
			break;
		case THCardSuitHearts:
			return @"Hearts";
			break;
		case THCardSuitSpades:
			return @"Spades";
			break;
		default:
			return @"?";
			break;
	}
}

-(NSString *)description {
	return [NSString stringWithFormat:@"%@ of %@",[self longRank],[self longSuit]];
}
-(id)initWithRandomValue {
    if ((self = [super init])) {
		suit = [THRandom randomNumberWithMin:0 withMax:3];
		rank = (THCardSuit)[THRandom randomNumberWithMin:1 withMax:13];
		faceUp = YES;
	}
	return self;
}

- (id)initWithSuit:(THCardSuit)theSuit rank:(int)theRank {
	if ((self = [super init])) {
		suit = theSuit;
		rank = theRank;
		faceUp = YES;
	}
	return self;
}

-(void)flip {
    faceUp = !faceUp;
}

- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		suit = (THCardSuit)[decoder decodeIntForKey:@"suit"];
		rank = [decoder decodeIntForKey:@"rank"];
		faceUp = [decoder decodeBoolForKey:@"faceUp"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeInt:rank forKey:@"rank"];
	[encoder encodeInt:(int)suit forKey:@"suit"];
	[encoder encodeBool:faceUp forKey:@"faceUp"];
}

@end
