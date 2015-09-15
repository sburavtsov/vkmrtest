#import "VKFriend.h"

@interface VKFriend ()

// Private interface goes here.

@end

@implementation VKFriend

// Custom logic goes here.

-(void)initWithDictionary:(NSDictionary *)dictionary {

    self.first_name = dictionary[@"first_name"];
    self.last_name = dictionary[@"last_name"];
    self.photo_url = dictionary[@"photo_50"];
    self.uid = dictionary[@"user_id"];
}

@end
