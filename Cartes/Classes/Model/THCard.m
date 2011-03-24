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

- (id)initWithSuit:(THCardSuit)theSuit rank:(int)theRank {
	if ((self = [super init])) {
		suit = theSuit;
		rank = theRank;
		faceUp = YES;
	}
	return self;
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
