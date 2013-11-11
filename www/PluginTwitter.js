
/**
 * Constructor.
 *
 */
function PluginTwitter() {
    
};

/**
 * Checks if the Twitter SDK is loaded
 * @param {Function} response callback on result
 * @param {Number} response.response is 1 for success, 0 for failure
 * @example
 *      window.plugins.twitter.isTwitterAvailable(function (response) {
 *          console.log("twitter available? " + response);
 *      });
 */
PluginTwitter.prototype.isTwitterAvailable = function(successCallback, errorCallback) {
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }
    
    if (typeof errorCallback != "function") {
        console.log("isTwitterAvailable failure: failure parameter not a function");
        return;
    }
    
    if (typeof successCallback != "function") {
        console.log("isTwitterAvailable failure: success callback parameter must be a function");
        return;
    }
    
    cordova.exec(successCallback, errorCallback, 'CDVPluginTwitter', 'isTwitterAvailable', []);
};

/**
 * Checks if the Twitter SDK can send a tweet
 * @param {Function} response callback on result
 * @param {Number} response.response is 1 for success, 0 for failure
 * @example
 *      window.plugins.twitter.isTwitterSetup(function (r) {
 *          console.log("twitter configured? " + r);
 *      });
 */
PluginTwitter.prototype.isTwitterSetup = function(successCallback, errorCallback){
    
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }
    
    if (typeof errorCallback != "function") {
        console.log("isTwitterSetup failure: failure parameter not a function");
        return;
    }
    
    if (typeof successCallback != "function") {
        console.log("isTwitterSetup failure: success callback parameter must be a function");
        return;
    }
    
    cordova.exec(successCallback, errorCallback, 'CDVPluginTwitter', 'isTwitterSetup', []);
    
};

/**
 * Gets Tweets from Twitter Mentions API
 * @param {Function} success callback
 * @param {String} success.response Twitter Username
 * @param {Object[]} success.result Tweet objects, see [Twitter Mentions Doc]
 * @param {Function} failure callback
 * @param {String} failure.error reason for failure
 *
 * [Twitter Mentions Doc]: https://dev.twitter.com/docs/api/1/get/statuses/mentions
 */
PluginTwitter.prototype.getTwitterUsername = function(successCallback, errorCallback) {

    if (errorCallback == null) {
        errorCallback = function () {
        };
    }
    
    if (typeof errorCallback != "function") {
        console.log("isTwitterSetup failure: failure parameter not a function");
        return;
    }
    
    if (typeof successCallback != "function") {
        console.log("isTwitterSetup failure: success callback parameter must be a function");
        return;
    }
    
    cordova.exec(successCallback, errorCallback, 'CDVPluginTwitter', 'getTwitterUsername', []);
    
};

/**
 * Sends a Tweet to Twitter
 * @param {Function} success callback
 * @param {Function} failure callback
 * @param {String} failure.error reason for failure
 * @param {String} tweetText message to send to twitter
 * @param {Object} options (optional)
 * @param {String} options.urlAttach URL to embed in Tweet
 * @param {String} options.imageAttach Image URL to embed in Tweet
 * @param {Number} response.response - 1 on success, 0 on failure
 * @example
 *     window.plugins.twitter.composeTweet(
 *         function () { console.log("tweet success"); },
 *         function (error) { console.log("tweet failure: " + error); },
 *         "Text, Image, URL",
 *         {
 *             urlAttach:"http://youtu.be/Ot-rPGv85u4",
 *             imageAttach:"http://i.ytimg.com/vi/obx2VOtx0qU/hqdefault.jpg?w=320&h=192&sigh=QD3HYoJj9dtiytpCSXhkaq1oG8M"
 *         }
 * );
 */
PluginTwitter.prototype.composeTweet = function(successCallback, errorCallback, tweetText, options){
    
    if (errorCallback == null) {
        errorCallback = function () {
        };
    }
    
    if (typeof errorCallback != "function") {
        console.log("isTwitterSetup failure: failure parameter not a function");
        return;
    }
    
    if (typeof successCallback != "function") {
        console.log("isTwitterSetup failure: success callback parameter must be a function");
        return;
    }
    
    options = options || {};
    options.text = tweetText;
    cordova.exec(successCallback, errorCallback, 'CDVPluginTwitter', 'composeTweet', [options]);
};

//module.exports = new PluginTwitter();
var PluginTwitter = new PluginTwitter();