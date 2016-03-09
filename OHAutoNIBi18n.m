//
//  OHAutoNIBi18n.m
//
//  Created by Olivier on 03/11/10.
//  Copyright 2010 FoodReporter. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

#ifdef TARGET_OS_IPHONE

@interface NSObject(OHAutoNIBi18n)
-(void)localizeNibObject;
@end


// ------------------------------------------------------------------------------------------------

@implementation NSObject(OHAutoNIBi18n)

#define LocalizeIfClass(Cls) if ([self isKindOfClass:[Cls class]]) localize##Cls((Cls*)self)

+(void)load {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        // Autoload : swizzle -awakeFromNib with -localizeNibObject as soon as the app (and thus this class) is loaded
        Method localizeNibObject = class_getInstanceMethod([NSObject class], @selector(localizeNibObject));
        Method awakeFromNib = class_getInstanceMethod([NSObject class], @selector(awakeFromNib));
        method_exchangeImplementations(awakeFromNib, localizeNibObject);
//        NSLog(@"sddasdas %@", [[self class] debugDescription]);
    });
}
@end
#endif


@implementation NSBundle (rescueLang)

-(NSString *)rescueLocalizedString:(NSString *)key {
    
    NSString *result = [[NSBundle mainBundle] localizedStringForKey:key value:@"" table:nil];
    
    if (!result || [result isEqualToString:@""] || [result isEqualToString:key]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:OHAutoNIBi18n_RESCUE_LANG ofType:@"lproj"];
        NSBundle *englishBundle = [NSBundle bundleWithPath:path];
        return [englishBundle localizedStringForKey:key value:@"" table:nil];
    }
    return result;
}

@end