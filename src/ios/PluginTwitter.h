//
//  CDVPluginTwitter.h
//  CustomPlugin
//
//  Created by Philip Lidstone on 04/11/2013.
//
//

#import <Cordova/CDV.h>
#import <Cordova/CDVJSON.h>
#import <Foundation/Foundation.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@interface CDVPluginTwitter : CDVPlugin

@property (strong, nonatomic) NSString *twitterUsername;

// This will return the file contents in a JSON object via the getFileContents utility method
- (void) cordovaGetFileContents:(CDVInvokedUrlCommand *)command;
// This will accept a String and call setFileContents to persist the String on to disk
- (void) cordovaSetFileContents:(CDVInvokedUrlCommand *)command;

- (void) isTwitterAvailable:(CDVInvokedUrlCommand*)command;
- (void) isTwitterSetup:(CDVInvokedUrlCommand*)command;
- (void) composeTweet:(CDVInvokedUrlCommand*)command;
- (void) getPublicTimeline:(CDVInvokedUrlCommand*)command;
- (void) getTwitterUsername:(CDVInvokedUrlCommand*)command;
- (void) getMentions:(CDVInvokedUrlCommand*)command;
- (void) getTWRequest:(CDVInvokedUrlCommand*)command;
- (void) performCallbackOnMainThreadforJS:(NSString*)js;

#pragma mark - Util_Methods

// Pure native code to persist data
- (void) setFileContents;

// Native code to load data from disk and return the String.
- (NSString *) getFileContents;

@end
