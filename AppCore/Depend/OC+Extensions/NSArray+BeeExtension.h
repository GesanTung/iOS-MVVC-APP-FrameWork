#pragma mark -
#import <Foundation/Foundation.h>
@interface NSArray(BeeExtension)

@property (nonatomic, readonly) NSMutableArray *	mutableArray;
//安全获取数组元素
- (id)safeObjectAtIndex:(NSInteger)index;
- (NSArray *)safeSubarrayWithRange:(NSRange)range;
@end
