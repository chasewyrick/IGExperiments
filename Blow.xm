//
//
//    Blow.xm
//    White Instagram
//    Created by CP Digital Darkroom <tweaks@cpdigitaldarkroom.support> 04/27/2016
//    © CP Digital Darkroom <tweaks@cpdigitaldarkroom.support>. All rights reserved.
//
//
//

#import "Blow.h"

%config(generator=internal)

static NSString *igeIdentifier;
static NSArray *igeExperimentSet0;
static NSArray *igeExperimentSet1;
static BOOL oldVersion;

%hook IGUserDetailViewController
-(void)viewDidAppear:(BOOL)animated {

	%orig;

	if(self.isShowingCurrentUser) {
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"/Library/Application Support/IGExperiments/experiments.png"] style:UIBarButtonItemStyleDone target:self action:@selector(showExperimentController)];
	}
}

%new
- (void)showExperimentController {

	if(oldVersion) {

		IGAlertView *alertView = [[NSClassFromString(@"IGAlertView") alloc] initWithTitle:@"IGExperiments" message:@"You are running an unsupported version of Instagram, please update to the latest version." cancelButtonTitle:@"Dismiss" otherButtonTitle:nil cancelBlock:nil  otherBlock:nil];
		[alertView show];
		[alertView release];

		return;
	}

	NSMutableArray *experiments = [NSMutableArray new];

	for(IGExperimentSpec *eSpec in igeExperimentSet0) {
		[experiments addObject:eSpec];
	}

	for(IGExperimentSpec *eSpec in igeExperimentSet1) {
		if(![experiments containsObject:eSpec]) {
			[experiments addObject:eSpec];
		}
	}

	IGExperimentSet *experimentSet = [[NSClassFromString(@"IGExperimentSet") alloc] initWithExperimentType:0 experimentSpecs:experiments uniqueIdentifier:igeIdentifier networker:[NSClassFromString(@"IGNetworker") sharedNetworker]];

	IGExperimentListViewController *experimentsController = [[NSClassFromString(@"IGExperimentCategoryListViewController") alloc] initWithTitle:@"Experiments" experimentSet:experimentSet];
	[self showViewController:experimentsController sender:nil];
}
%end

%hook IGExperimentSet
-(id)initWithExperimentType:(int)type experimentSpecs:(NSArray *)experiments uniqueIdentifier:(NSString *)identifier networker:(id)networker {

	if(type == 0) {
		igeIdentifier = identifier;
		igeExperimentSet0 = experiments;
	}

	if(type == 1) {
		igeExperimentSet1 = experiments;
	}
	return %orig;
}
%end

%ctor {
	NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSComparisonResult newestWaveVersionComparisonResult = [version compare:@"10.2" options:NSNumericSearch];

	if (newestWaveVersionComparisonResult == NSOrderedAscending) {
		oldVersion = YES;
	}
}
