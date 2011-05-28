//
//  CartesViewController.m
//  Cartes
//
//  Created by Tom Hartley on 24/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CartesViewController.h"
#import "THCardView.h"
#import "THCard.h"
@implementation CartesViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	UIImageView *iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardTableBackground.png"]];
	[self.view addSubview:iView];
	[iView autorelease];
    
    for (int i = 0;i < 13; i++) {
        THCardView *cardView = [[THCardView alloc] initAtOrigin:CGPointMake(i*60, 0) withCard:[[THCard alloc] initWithSuit:THCardSuitSpades rank:i+1]];
        [self.view addSubview:cardView];
    }

    for (int i = 0;i < 13; i++) {
        THCardView *cardView = [[THCardView alloc] initAtOrigin:CGPointMake(i*60, 150) withCard:[[THCard alloc] initWithSuit:THCardSuitHearts rank:i+1]];
        [self.view addSubview:cardView];
    }
    for (int i = 0;i < 13; i++) {
        THCardView *cardView = [[THCardView alloc] initAtOrigin:CGPointMake(i*60, 300) withCard:[[THCard alloc] initWithSuit:THCardSuitDiamonds rank:i+1]];
        [self.view addSubview:cardView];
    }
    for (int i = 0;i < 13; i++) {
        THCardView *cardView = [[THCardView alloc] initAtOrigin:CGPointMake(i*60, 450) withCard:[[THCard alloc] initWithSuit:THCardSuitClubs rank:i+1]];
        [self.view addSubview:cardView];
    }

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
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        return YES;
    }
    return NO;
}

@end
