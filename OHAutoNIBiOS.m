//
//  OHAutoNIBiOS.m
//  OHAutoNIBi18n
//
//  Created by Adam Lipka on 07.03.2016.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OHL10nMacros.h"

static inline NSString* localizedString(NSString* aString);

static inline void localizeUIBarButtonItem(UIBarButtonItem* bbi);
static inline void localizeUIBarItem(UIBarItem* bi);
static inline void localizeUIButton(UIButton* btn);
static inline void localizeUILabel(UILabel* lbl);
static inline void localizeUINavigationItem(UINavigationItem* ni);
static inline void localizeUISearchBar(UISearchBar* sb);
static inline void localizeUISegmentedControl(UISegmentedControl* sc);
static inline void localizeUITextField(UITextField* tf);
static inline void localizeUITextView(UITextView* tv);
static inline void localizeUIViewController(UIViewController* vc);


@implementation NSObject(OHAutoNIBi18niOS)

#define LocalizeIfClass(Cls) if ([self isKindOfClass:[Cls class]]) localize##Cls((Cls*)self)
-(void)localizeNibObject
{
    LocalizeIfClass(UIBarButtonItem);
    else LocalizeIfClass(UIBarItem);
    else LocalizeIfClass(UIButton);
    else LocalizeIfClass(UILabel);
    else LocalizeIfClass(UINavigationItem);
    else LocalizeIfClass(UISearchBar);
    else LocalizeIfClass(UISegmentedControl);
    else LocalizeIfClass(UITextField);
    else LocalizeIfClass(UITextView);
    else LocalizeIfClass(UIViewController);

    if (![self isKindOfClass:UITableView.class] && (self.isAccessibilityElement == YES))
    {
        // Security to avoid translating tableView's accessibilityLabel & accessibilityHint
        // since it seems to provoke a crash on some configurations
        // See https://github.com/AliSoftware/OHAutoNIBi18n/issues/3
        self.accessibilityLabel = localizedString(self.accessibilityLabel);
        self.accessibilityHint = localizedString(self.accessibilityHint);
    }

    // Call the original awakeFromNib method
    [self localizeNibObject]; // this actually calls the original awakeFromNib (and not localizeNibObject) because we did some method swizzling
}

@end

// ------------------------------------------------------------------------------------------------



/////////////////////////////////////////////////////////////////////////////


static inline NSString* localizedString(NSString* aString)
{
    if (aString == nil || [aString length] == 0)
        return aString;

    // Don't translate strings starting with a digit
    if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:[aString characterAtIndex:0]])
        return aString;

#if OHAutoNIBi18n_DEBUG
#warning Debug mode for i18n is active
    static NSString* const kNoTranslation = @"$!";
    NSString* tr = [[NSBundle mainBundle] localizedStringForKey:aString value:kNoTranslation table:nil];
    if ([tr isEqualToString:kNoTranslation])
    {
        if ([aString hasPrefix:@"."])
        {
            // strings in XIB starting with '.' are typically used as temporary placeholder for design
            // and will be replaced by code later, so don't warn about them
            return aString;
        }
        NSLog(@"No translation for string '%@'",aString);
        tr = [NSString stringWithFormat:@"$%@$",aString];
    }
    return tr;
#else
    NSString *result = [[NSBundle mainBundle] rescueLocalizedString:aString];
#endif
    return result;
}


static inline void localizeUIBarButtonItem(UIBarButtonItem* bbi) {
    localizeUIBarItem(bbi); /* inheritence */

    NSMutableSet* locTitles = [[NSMutableSet alloc] initWithCapacity:[bbi.possibleTitles count]];
    for(NSString* str in bbi.possibleTitles) {
        [locTitles addObject:localizedString(str)];
    }
    bbi.possibleTitles = [NSSet setWithSet:locTitles];
#if ! __has_feature(objc_arc)
    [locTitles release];
#endif
}

static inline void localizeUIBarItem(UIBarItem* bi) {
    bi.title = localizedString(bi.title);
}

static inline void localizeUIButton(UIButton* btn) {
    NSString* title[4] = {
        [btn titleForState:UIControlStateNormal],
        [btn titleForState:UIControlStateHighlighted],
        [btn titleForState:UIControlStateDisabled],
        [btn titleForState:UIControlStateSelected]
    };

    [btn setTitle:localizedString(title[0]) forState:UIControlStateNormal];
    if (title[1] == [btn titleForState:UIControlStateHighlighted])
        [btn setTitle:localizedString(title[1]) forState:UIControlStateHighlighted];
    if (title[2] == [btn titleForState:UIControlStateDisabled])
        [btn setTitle:localizedString(title[2]) forState:UIControlStateDisabled];
    if (title[3] == [btn titleForState:UIControlStateSelected])
        [btn setTitle:localizedString(title[3]) forState:UIControlStateSelected];
}

static inline void localizeUILabel(UILabel* lbl) {
    lbl.text = localizedString(lbl.text);
}

static inline void localizeUINavigationItem(UINavigationItem* ni) {
    ni.title = localizedString(ni.title);
    ni.prompt = localizedString(ni.prompt);
}

static inline void localizeUISearchBar(UISearchBar* sb) {
    sb.placeholder = localizedString(sb.placeholder);
    sb.prompt = localizedString(sb.prompt);
    sb.text = localizedString(sb.text);

    NSMutableArray* locScopesTitles = [[NSMutableArray alloc] initWithCapacity:[sb.scopeButtonTitles count]];
    for(NSString* str in sb.scopeButtonTitles) {
        [locScopesTitles addObject:localizedString(str)];
    }
    sb.scopeButtonTitles = [NSArray arrayWithArray:locScopesTitles];
#if ! __has_feature(objc_arc)
    [locScopesTitles release];
#endif
}

static inline void localizeUISegmentedControl(UISegmentedControl* sc) {
    NSUInteger n = sc.numberOfSegments;
    for(NSUInteger idx = 0; idx<n; ++idx) {
        [sc setTitle:localizedString([sc titleForSegmentAtIndex:idx]) forSegmentAtIndex:idx];
    }
}

static inline void localizeUITextField(UITextField* tf) {
    tf.text = localizedString(tf.text);
    tf.placeholder = localizedString(tf.placeholder);
}

static inline void localizeUITextView(UITextView* tv) {
    tv.text = localizedString(tv.text);
}

static inline void localizeUIViewController(UIViewController* vc) {
    vc.title = localizedString(vc.title);
}
