#import "TheosExample1ListController.h"

@implementation TheosExample1ListController
- (id)init
{
	if ((self = [super init]) != nil) {
		_settings = [NSMutableDictionary dictionaryWithContentsOfFile:_plistfile] ?: [NSMutableDictionary dictionary];
	}

	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	if (!self.table.tableHeaderView) {
		self.table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, CGFLOAT_MIN)];
	}
}

// -(void)viewWillAppear:(BOOL)animated
// {
// 	_settings = ([NSMutableDictionary dictionaryWithContentsOfFile:_plistfile] ?: [NSMutableDictionary dictionary]);
// 	[super viewWillAppear:animated];
// 	[self reload];
// }

- (id)specifiers
{
	if (_specifiers == nil) {
		_specifiers = [self loadSpecifiersFromPlistName:@"TheosExample1" target:self];
	}

	return _specifiers;
}

- (void)setCellForRowAtIndexPath:(NSIndexPath *)indexPath enabled:(BOOL)enabled
{
	UITableViewCell *cell = [self tableView:self.table cellForRowAtIndexPath:indexPath];
	if (cell) {
		cell.userInteractionEnabled = enabled;
		cell.textLabel.enabled = enabled;
		cell.detailTextLabel.enabled = enabled;

		if ([cell isKindOfClass:[PSControlTableCell class]]) {
			PSControlTableCell *controlCell = (PSControlTableCell *)cell;
			if (controlCell.control) {
				controlCell.control.enabled = enabled;
			}
		}
	}
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier
{
	NSString *key = [specifier propertyForKey:@"key"];
	_settings = ([NSMutableDictionary dictionaryWithContentsOfFile:_plistfile] ?: [NSMutableDictionary dictionary]);
	[_settings setObject:value forKey:key];
	[_settings writeToFile:_plistfile atomically:YES];

	if ([key isEqualToString:@"enabled"]) {
		BOOL enableCell = [value boolValue];
		[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] enabled:enableCell];
		[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] enabled:enableCell];
		[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] enabled:enableCell];
	}

	NSString *post = [specifier propertyForKey:@"PostNotification"];
	if (post) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),  (__bridge CFStringRef)post, NULL, NULL, TRUE);
	}
}

- (id)readPreferenceValue:(PSSpecifier *)specifier
{
	NSString *key = [specifier propertyForKey:@"key"];
	id defaultValue = [specifier propertyForKey:@"default"];
	id plistValue = [_settings objectForKey:key];
	if (!plistValue) plistValue = defaultValue;

	if ([key isEqualToString:@"enabled"]) {
		BOOL enableCell = plistValue && [plistValue boolValue];
		[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] enabled:enableCell];
		[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] enabled:enableCell];
		[self setCellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] enabled:enableCell];
	}

	return plistValue;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = (UITableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
	[cell.textLabel setAdjustsFontSizeToFitWidth:YES];

	if ([cell isKindOfClass:[PSSwitchTableCell class]]) {
		UISwitch *contactSwitch = (UISwitch *)((PSControlTableCell *)cell).control;
		contactSwitch.onTintColor = self.navigationController.navigationBar.tintColor;
	}

	return cell;
}

// - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
// {
// 	if (indexPath.section == 0 && indexPath.row == 2) {
// 		return 70;
// 	}
//
// 	return 44;
// }
@end
