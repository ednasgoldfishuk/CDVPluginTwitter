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

- (void) isTwitterAvailable:(CDVInvokedUrlCommand*)command;
- (void) isTwitterSetup:(CDVInvokedUrlCommand*)command;
- (void) composeTweet:(CDVInvokedUrlCommand*)command;
- (void) getTwitterUsername:(CDVInvokedUrlCommand*)command;

@end
