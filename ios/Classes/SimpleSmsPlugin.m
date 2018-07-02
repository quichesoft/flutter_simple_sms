#import "SimpleSmsPlugin.h"

@interface SimpleSmsPlugin()

- (void)sendSms:(NSArray*) addresses message:(NSString*) message;

@end

@implementation SimpleSmsPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"plugins.quichesoft.com/simpleSms"
            binaryMessenger:[registrar messenger]];
  SimpleSmsPlugin* instance = [[SimpleSmsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSLog(@"%@", call.method);
  if ([@"sendSms" isEqualToString:call.method]) {
    NSArray *addresses = call.arguments[@"addresses"];
    NSString *message = call.arguments[@"message"];
    [self sendSms: addresses message: message];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void) sendSms:(NSArray*) addresses message:(NSString*) message {
    if([MFMessageComposeViewController canSendText]) {
            MFMessageComposeViewController* controller = [[MFMessageComposeViewController alloc] init];
            controller.body = message;
            controller.recipients = addresses;
            controller.messageComposeDelegate = self;
            [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:controller animated:true completion:nil];
        }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
