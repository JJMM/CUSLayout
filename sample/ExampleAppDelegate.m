#import "CUSMainViewController.h"

@implementation ExampleAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    CUSMainViewController *mainController = [[CUSMainViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainController];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
