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
	UILabel *topLeftLabel;
	UILabel *bottomRightLabel;
}

@property (nonatomic, retain) THCard *card;

-(void)update;

@end
