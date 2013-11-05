//
//  CDVPluginTwitter.m
//  CustomPlugin
//
//  Created by Philip Lidstone on 04/11/2013.
//
//

#import "CDVPluginTwitter.h"

#define TWITTER_URL @"http://api.twitter.com/1.1/"

@implementation CDVPluginTwitter

- (void) isTwitterAvailable:(CDVInvokedUrlCommand*)command {
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    BOOL *twitterSDKAvailable = tweetViewController != nil;

    NSMutableDictionary* twitterData = [NSMutableDictionary dictionaryWithCapacity:1];
    [twitterData setObject:[NSNumber numberWithBool:twitterSDKAvailable] forKey:@"isAvailable"];
    

    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:twitterData];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
}

- (void) isTwitterSetup:(CDVInvokedUrlCommand*)command {
    BOOL canTweet = [TWTweetComposeViewController canSendTweet];
    
    NSMutableDictionary* twitterData = [NSMutableDictionary dictionaryWithCapacity:1];
    [twitterData setObject:[NSNumber numberWithBool:canTweet] forKey:@"isSetup"];
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:twitterData];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
}

- (void) getTwitterUsername:(CDVInvokedUrlCommand*)command {

    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    // Create an account type that ensures Twitter accounts are retrieved.
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        
        if(granted) {
            
            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
            
            for (ACAccount *account in accountsArray ) {

                self.twitterUsername = account.username;
            }

            NSLog(@"Accounts array: %d", accountsArray.count);
            
            NSLog (@"%@", self.twitterUsername);
            if (self.twitterUsername == nil) self.twitterUsername = @"undefined";
            NSMutableDictionary* twitterData = [NSMutableDictionary dictionaryWithCapacity:1];
            [twitterData setObject:self.twitterUsername forKey:@"username"];
            
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:twitterData];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            
        }
    }];
    
}

- (void) composeTweet:(CDVInvokedUrlCommand*)command {
    // arguments: callback, tweet text, url attachment, image attachment
    NSMutableDictionary* options = (NSMutableDictionary*)[command argumentAtIndex:0];
    NSString *callbackId = command.callbackId;
    NSString *tweetText = [options objectForKey:@"text"];
    NSString *urlAttach = [options objectForKey:@"urlAttach"];
    NSString *imageAttach = [options objectForKey:@"imageAttach"];
    
    TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
    
    BOOL ok = YES;
    NSString *errorMessage;
    
    if(tweetText != nil){
        ok = [tweetViewController setInitialText:tweetText];
        if(!ok){
            errorMessage = @"Tweet is too long";
        }
    }
    
    
    
    if(imageAttach != nil){
        // Note that the image is loaded syncronously
        if([imageAttach hasPrefix:@"http://"]){
            UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageAttach]]];
            ok = [tweetViewController addImage:img];
        }
        else{
            ok = [tweetViewController addImage:[UIImage imageNamed:imageAttach]];
        }
        if(!ok){
            errorMessage = @"Image could not be added";
        }
    }
    
    if(urlAttach != nil){
        ok = [tweetViewController addURL:[NSURL URLWithString:urlAttach]];
        if(!ok){
            errorMessage = @"URL too long";
        }
    }
    
    
    
    if(!ok){
        [super writeJavascript:[[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                  messageAsString:errorMessage] toErrorCallbackString:callbackId]];
    }
    else{
        
#if TARGET_IPHONE_SIMULATOR
        NSString *simWarning = @"Test TwitterPlugin on Real Hardware. Tested on Cordova 2.0.0";
        //EXC_BAD_ACCESS occurs on simulator unable to reproduce on real device
        //running iOS 5.1 and Cordova 1.6.1
        NSLog(@"%@",simWarning);
#endif
        
        [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
            switch (result) {
                case TWTweetComposeViewControllerResultDone:
                    [super writeJavascript:[[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] toSuccessCallbackString:callbackId]];
                    break;
                case TWTweetComposeViewControllerResultCancelled:
                default:
                    [super writeJavascript:[[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                              messageAsString:@"Cancelled"] toErrorCallbackString:callbackId]];
                    break;
            }
            
            [super.viewController dismissModalViewControllerAnimated:YES];
            
        }];
        
        [super.viewController presentModalViewController:tweetViewController animated:YES];
    }
}

@end
