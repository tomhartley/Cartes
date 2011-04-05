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
	
	THCardView *cardView = [[THCardView alloc]initWithFrame:CGRectMake(50, 50, 120, 168)];
	cardView.card = [[THCard alloc] initWithSuit:THCardSuitHearts rank:1];
	[cardView update];
	[self.view addSubview:cardView];
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
