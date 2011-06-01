//
//  THGameBoardController.h
//  Cartes
//
//  Created by Tom Hartley on 31/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THCardGame.h"
#import "THCardView.h"
@interface THGameBoardController : UIViewController {
    THCardGame *game;
    UIImageView *backgroundImage;
}

-(void)addCard:(THCard *)card fromLocation:(THPlayerLocation)location;
-(IBAction)addRandomCard;

@end
