//
//  THGameBoardController.m
//  Cartes
//
//  Created by Tom Hartley on 31/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "THGameBoardController.h"


@implementation THGameBoardController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        game = [[THCardGame alloc] initWithMaxPlayers:2];
        game.delegate = self;
    }
    return self;
}

-(void)addCard:(THCard *)card fromLocation:(THPlayerLocation)location {
    THCardView *newView = [[THCardView alloc] initAtOrigin:CGPointMake(100,100) withCard:card];
    [self.view addSubview:newView];
    [newView autorelease];
}

-(IBAction)addRandomCard {
    THCard *randomCard = [[THCard alloc] initWithRandomValue];
    THCardView *newView = [[THCardView alloc] initAtOrigin:CGPointMake([THRandom randomNumberWithMin:0 withMax:1000], [THRandom randomNumberWithMin:0 withMax:500]) withCard:randomCard];
    [randomCard autorelease];
    [self.view addSubview:newView];
    [newView autorelease];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardTableBackground.png"]];
	[self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
	[backgroundImage autorelease];
    
}

- (void)dealloc
{
    [backgroundImage removeFromSuperview];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
