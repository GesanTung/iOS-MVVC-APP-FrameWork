
#import "NSArray+BeeExtension.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSArray(BeeExtension)

- (id)safeObjectAtIndex:(NSInteger)index
{
	if ( index < 0 )
		return nil;
	
	if ( index >= self.count )
		return nil;

	return [self objectAtIndex:index];
}

- (NSArray *)safeSubarrayWithRange:(NSRange)range
{
	if ( 0 == self.count )
		return nil;

	if ( range.location >= self.count )
		return nil;

	if ( range.location + range.length >= self.count )
		return nil;
	
	return [self subarrayWithRange:NSMakeRange(range.location, range.length)];
}

- (NSMutableArray *)mutableArray
{
	return [NSMutableArray arrayWithArray:self];
}
@end

