//
//  THCardView.h
//  Cartes
//
//  Created by Tom Hartley on 24/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THCard.h"

@interface THCardView : UIView {
    THCard *card;

	CGPoint velocity;
	
	UIView *frontView;
	UIView *backView;
	
	UILabel *topLeftNumber;
	UILabel *topLeftSuit;

	UILabel *bottomRightNumber;
	UILabel *bottomRightSuit;
	
	UILabel *centerSuit;
}

@property (nonatomic, retain) THCard *card;

-(void)update;

- (id)initAtOrigin:(CGPoint)origin withCard:(THCard *)theCard;

//UIGestureRecognizer handlers
- (void)handleDoubleTap:(UITapGestureRecognizer *)sender;
- (void)handlePan:(UIPanGestureRecognizer *)sender;
@end
