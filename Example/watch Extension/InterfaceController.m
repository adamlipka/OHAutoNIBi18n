//
//  InterfaceController.m
//  watch Extension
//
//  Created by Adam Lipka on 07.03.2016.
//
//

#import "InterfaceController.h"

@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *greetings;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [_greetings setText:XTBLocalize(_greetings.interfaceProperty)];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



