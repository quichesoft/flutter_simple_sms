#import <Flutter/Flutter.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface SimpleSmsPlugin : NSObject<FlutterPlugin, MFMessageComposeViewControllerDelegate>
@end
