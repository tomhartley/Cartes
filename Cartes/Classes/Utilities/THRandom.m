//
//  THRandom.m
//  ControlPanel
//
//  Created by Tom Hartley on 13/04/10.
//  Copyright 2010 Tom Hartley. All rights reserved.
//

#import "THRandom.h"


@implementation THRandom

+(NSInteger)randomNumberWithMin:(NSInteger)min withMax:(NSInteger)max {
	if (min>max) {
		int tempMax=max;
		max=min;
		min=tempMax;
	}
	int randomy=arc4random() % (max-min+1);
	randomy=randomy+min;
	//NSLog(@"Random number from %d to %d was %d", min, max, randomy);
	return randomy;
}

+(NSArray *)randomChoiceOf:(NSInteger)howManyToChoose withAllOptions:(NSInteger)numberToChooseFrom {
	//Create requisite arrays
	NSMutableArray *finalChoices=[[NSMutableArray alloc] init];
	NSMutableArray *cutDown=[[NSMutableArray alloc] init];
	
	//"fill up" array with numnbers...
	for (NSInteger a=0; a<numberToChooseFrom; a++) {
		[cutDown addObject:[NSString stringWithFormat:@"%d", a]];
	}
	
	//Repeat for the number chosen you want...
	for (NSInteger a=0; a<howManyToChoose; a++) {
		//Gives you a number between 0 and the count of cutdown-1 (because count is total, and we need index)
		NSInteger pickedNumber = [THRandom randomNumberWithMin:0 withMax:[cutDown count]-1];
		//NSLog(@"pickedNumber: %@", [cutDown objectAtIndex:pickedNumber]);
		[finalChoices addObject:[cutDown objectAtIndex:pickedNumber]];
		[cutDown removeObjectAtIndex:pickedNumber];
	}
	//NSLog(@"finalChoices(should be %d from %d): %@", howManyToChoose ,numberToChooseFrom , finalChoices);
	[cutDown release];
	return [finalChoices autorelease];
}

+(NSArray *)randomArrayMin:(NSInteger)minimum withMax:(NSInteger)maximum withLength:(NSInteger)arrayLength {
	NSMutableArray *arrayToReturn =[NSMutableArray arrayWithCapacity:arrayLength];
	for (int a=0; a<arrayLength; a++) {
		[arrayToReturn addObject:[NSString stringWithFormat:@"%d", [THRandom randomNumberWithMin:minimum withMax:maximum]]];
	}
	return arrayToReturn;
}

+(NSArray *)randomArrayFrom:(NSArray *)arrayToChooseFrom withLength:(NSInteger)length {
	NSMutableArray *array=[NSMutableArray arrayWithCapacity:length];
	for (int a=0; a<length; a++) {
		[array addObject:[NSString stringWithFormat:@"%d",[[arrayToChooseFrom objectAtIndex:[THRandom randomNumberWithMin:0 withMax:[arrayToChooseFrom count]-1]]intValue]]];
	}
	return array;
}
@end




//3 and 7
//7-3=4
//random(4) will give you a number between 0 and 3 inclusive
//0+3=3
/*

0 and 1
1-0=1
*/
