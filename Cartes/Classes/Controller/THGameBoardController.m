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
        game = [[THCardGame alloc] initWithMaxPlayers:4];
        game.delegate = self;
    }
    return self;
    
}

-(void)addCard:(THCard *)card fromLocation:(THPlayerLocation)location {
    THCardView *newView = [[THCardView alloc] initAtOrigin:CGPointMake(100,100) withCard:card];
    //1024 by 768
    [newView autorelease];
    CGPoint centerPoint;
    switch (location) {
        case THPlayerLocationNorth:
            centerPoint = CGPointMake(512, -200);
            break;
        case THPlayerLocationSouth:
            centerPoint = CGPointMake(512, 968);
            break;
        case THPlayerLocationEast:
            centerPoint = CGPointMake(384, -200);
            break;
        case THPlayerLocationWest:
            centerPoint = CGPointMake(384, 1224);
            break;
        default:
            centerPoint = CGPointMake(512, -200);
            break;
    }
    newView.center = centerPoint;
    [self.view addSubview:newView];
    CGPoint newCenter = CGPointMake([THRandom randomNumberWithMin:200 withMax:824], [THRandom randomNumberWithMin:200 withMax:568]);
    [UIView beginAnimations:@"moveCard" context:nil];
    [UIView setAnimationDuration:0.8];
    newView.center = newCenter;
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView commitAnimations];
}

-(IBAction)addRandomCard {
    THCard *randomCard = [[THCard alloc] initWithRandomValue];
    [randomCard autorelease];
    [self addCard:randomCard fromLocation:THPlayerLocationNorth];
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
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
