// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to VKFriend.h instead.

@import CoreData;

extern const struct VKFriendAttributes {
	__unsafe_unretained NSString *first_name;
	__unsafe_unretained NSString *last_name;
	__unsafe_unretained NSString *photo_url;
	__unsafe_unretained NSString *uid;
} VKFriendAttributes;

@interface VKFriendID : NSManagedObjectID {}
@end

@interface _VKFriend : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) VKFriendID* objectID;

@property (nonatomic, strong) NSString* first_name;

//- (BOOL)validateFirst_name:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* last_name;

//- (BOOL)validateLast_name:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* photo_url;

//- (BOOL)validatePhoto_url:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* uid;

@property (atomic) int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;

@end

@interface _VKFriend (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveFirst_name;
- (void)setPrimitiveFirst_name:(NSString*)value;

- (NSString*)primitiveLast_name;
- (void)setPrimitiveLast_name:(NSString*)value;

- (NSString*)primitivePhoto_url;
- (void)setPrimitivePhoto_url:(NSString*)value;

- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;

@end
