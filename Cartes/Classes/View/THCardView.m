//
//  THCardView.m
//  Cartes
//
//  Created by Tom Hartley on 24/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "THCardView.h"
#import <QuartzCore/QuartzCore.h>

@implementation THCardView
@synthesize card;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.layer.cornerRadius = 10;
		self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
		self.layer.borderColor = [[UIColor colorWithWhite:0.3 alpha:1] CGColor];
		self.layer.borderWidth = 3;
	}
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
