#import "../headers.h"
// #import <Preferences/Preferences.h>

@interface TheosExample1ListController: PSListController {
	NSMutableDictionary *_settings;
}
- (void)setCellForRowAtIndexPath:(NSIndexPath *)indexPath enabled:(BOOL)enabled;
@end
