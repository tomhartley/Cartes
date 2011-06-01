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

- (id)initAtOrigin:(CGPoint)origin withCard:(THCard *)theCard
{
	CGRect frame = CGRectMake(origin.x, origin.y, 120, 168);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.layer.cornerRadius = 10;

		self.backgroundColor = [UIColor clearColor];
		self.layer.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1].CGColor;

		/*self.layer.shadowRadius = 2;
		self.layer.shadowOffset = CGSizeMake(3, 3);
		self.layer.shadowOpacity = 0.4;
        */
        
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.0;
        
		self.layer.contents = (id)[UIImage imageNamed:@"CardBackground.png"].CGImage;
		
		frontView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-20, self.frame.size.height-20)];
		frontView.backgroundColor = [UIColor clearColor];
		backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-20, self.frame.size.height-20)];
		
		centerSuit = [[UILabel alloc] initWithFrame:frontView.bounds];
		centerSuit.textAlignment = UITextAlignmentCenter;
		centerSuit.font = [UIFont systemFontOfSize:70];
		centerSuit.backgroundColor = [UIColor clearColor];
		[frontView addSubview:centerSuit];
		
		topLeftNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
		topLeftNumber.textAlignment = UITextAlignmentCenter;
		topLeftNumber.font = [UIFont fontWithName:@"CourierNewPSMT" size:30];
		topLeftNumber.adjustsFontSizeToFitWidth = YES;
		topLeftNumber.backgroundColor = [UIColor clearColor];
		[frontView addSubview:topLeftNumber];

		topLeftSuit = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 20, 15)];
		topLeftSuit.textAlignment = UITextAlignmentCenter;
		topLeftSuit.font = [UIFont fontWithName:@"CourierNewPSMT" size:22];
		topLeftSuit.adjustsFontSizeToFitWidth = YES;
		topLeftSuit.backgroundColor = [UIColor clearColor];
		[frontView addSubview:topLeftSuit];
        
		bottomRightNumber = [[UILabel alloc] initWithFrame:CGRectMake(frontView.frame.size.width-20, frontView.frame.size.height-30, 20, 30)];
		bottomRightNumber.textAlignment = UITextAlignmentCenter;
		bottomRightNumber.font = [UIFont fontWithName:@"CourierNewPSMT" size:30];
		bottomRightNumber.adjustsFontSizeToFitWidth = YES;
		bottomRightNumber.backgroundColor = [UIColor clearColor];
		bottomRightNumber.transform = CGAffineTransformMakeRotation(M_PI);
		[frontView addSubview:bottomRightNumber];
		
		bottomRightSuit = [[UILabel alloc] initWithFrame:CGRectMake(frontView.frame.size.width-20, frontView.frame.size.height-50, 20, 15)];
		bottomRightSuit.textAlignment = UITextAlignmentCenter;
		bottomRightSuit.font = [UIFont fontWithName:@"CourierNewPSMT" size:22];
		bottomRightSuit.adjustsFontSizeToFitWidth = YES;
		bottomRightSuit.backgroundColor = [UIColor clearColor];
		bottomRightSuit.transform = CGAffineTransformMakeRotation(M_PI);
		[frontView addSubview:bottomRightSuit];

		
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
		tapRecognizer.numberOfTapsRequired = 2;
		[self addGestureRecognizer:tapRecognizer];
		[tapRecognizer autorelease];

        UITapGestureRecognizer *tripleTapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTripleTap:)];
		tripleTapRecogniser.numberOfTapsRequired = 3;
		[self addGestureRecognizer:tripleTapRecogniser];
		[tripleTapRecogniser autorelease];

        
		UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
		[self addGestureRecognizer:panRecognizer];
		[panRecognizer autorelease];
		//self.clipsToBounds = YES;
		
		[self addSubview:frontView];
        
        card = [theCard retain];
        
        [self.card addObserver:self forKeyPath:@"faceUp" options:0 context:nil];
        
        [self update];
	}
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //The card's faceUp property changed
    [self update];
}


- (void)handleDoubleTap:(UITapGestureRecognizer *)sender {
	if (sender.state == UIGestureRecognizerStateEnded) {   
		// handling code
		[UIView beginAnimations:@"FlipCard" context:nil];
        card.faceUp = !card.faceUp;
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
		[UIView setAnimationDuration:0.6];
		[UIView commitAnimations];
	} 
}

- (void)handleTripleTap:(UITapGestureRecognizer *)sender {
    [self removeFromSuperview];
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
	if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
		velocity.x = 0;
		velocity.y = 0;
		CGPoint translation = [sender translationInView:self.superview];
		[self setCenter:CGPointMake(self.center.x + translation.x, self.center.y + translation.y)];
		[sender setTranslation:CGPointZero inView:self.superview];
	} else if (sender.state == UIGestureRecognizerStateEnded) {
		//Lets try for flicking
		velocity = [sender velocityInView:self];
		[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updatePosition:) userInfo:nil repeats:YES];
	}
	[[self superview] bringSubviewToFront:self];
}

-(void)updatePosition:(NSTimer *)timer {
	velocity.x = velocity.x * 0.85;
	velocity.y = velocity.y * 0.85;
	CGRect newRect = CGRectMake(self.frame.origin.x+(velocity.x)/100, self.frame.origin.y+(velocity.y)/100, self.frame.size.width, self.frame.size.height);
	//[self setCenter:CGPointMake(self.center.x + (velocity.x)/100, self.center.y + (velocity.y)/100)];
	if (CGRectContainsRect([self superview].bounds, newRect)) {
		self.frame = newRect;
	} else {
		velocity.x = - velocity.x;
		velocity.y = - velocity.y;
		//[timer invalidate];
	}
	if (velocity.x < 0.01 && velocity.x > -0.01) {
		velocity.x = 0;
	}
	if (velocity.y < 0.001 && velocity.y > -0.01) {
		velocity.y = 0;
	}
	
	if (velocity.y==0 && velocity.x == 0) {
		self.center = CGPointMake(floor(self.center.x+0.5), floor(self.center.y+0.5));
		
		[timer invalidate];
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)update {
	if (card.faceUp) {
		[backView removeFromSuperview];
		[self addSubview:frontView];
	} else {
		[frontView removeFromSuperview];
		[self addSubview:backView];
	}
	topLeftNumber.text = [card shortRank];
	topLeftSuit.text = [card shortSuit];
	bottomRightNumber.text = [card shortRank];
	bottomRightSuit.text = [card shortSuit];
	
	centerSuit.text = [card shortSuit];
	
	if (card.suit == THCardSuitClubs || card.suit == THCardSuitSpades) {
		topLeftNumber.textColor = [UIColor blackColor];
		topLeftSuit.textColor = [UIColor blackColor];
		bottomRightNumber.textColor = [UIColor blackColor];
		bottomRightSuit.textColor = [UIColor blackColor];
		centerSuit.textColor = [UIColor blackColor];
	} else {
		topLeftNumber.textColor = [UIColor redColor];
		topLeftSuit.textColor = [UIColor redColor];
		bottomRightNumber.textColor = [UIColor redColor];
		bottomRightSuit.textColor = [UIColor redColor];
		centerSuit.textColor = [UIColor redColor];
	}
}

- (void)dealloc
{
    [frontView removeFromSuperview];
    [frontView release];
    [backView removeFromSuperview];
    [backView release];
    [topLeftNumber removeFromSuperview];
    [topLeftNumber release];
    [topLeftSuit removeFromSuperview];
    [topLeftSuit release];
    [bottomRightNumber removeFromSuperview];
    [bottomRightNumber release];
    [bottomRightSuit removeFromSuperview];
    [bottomRightSuit release];
    [centerSuit removeFromSuperview];
    [centerSuit release];
    [card removeObserver:self forKeyPath:@"faceUp"];
    [card release];
    [super dealloc];
}

@end
