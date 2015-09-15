// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to VKFriend.m instead.

#import "_VKFriend.h"

const struct VKFriendAttributes VKFriendAttributes = {
	.first_name = @"first_name",
	.last_name = @"last_name",
	.photo_url = @"photo_url",
	.uid = @"uid",
};

@implementation VKFriendID
@end

@implementation _VKFriend

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"VKFriend" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"VKFriend";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"VKFriend" inManagedObjectContext:moc_];
}

- (VKFriendID*)objectID {
	return (VKFriendID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"uidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"uid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic first_name;

@dynamic last_name;

@dynamic photo_url;

@dynamic uid;

- (int64_t)uidValue {
	NSNumber *result = [self uid];
	return [result longLongValue];
}

- (void)setUidValue:(int64_t)value_ {
	[self setUid:@(value_)];
}

- (int64_t)primitiveUidValue {
	NSNumber *result = [self primitiveUid];
	return [result longLongValue];
}

- (void)setPrimitiveUidValue:(int64_t)value_ {
	[self setPrimitiveUid:@(value_)];
}

@end

