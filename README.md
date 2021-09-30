# TestRudder

Testing updated implementation of Rudder SDK with `anonymousId`.

The `anonymousId` will be used, and it will be the same per app, unless user logs out of the app.

## Running

0. Set `dataplaneURL` and `writeKey` on AppDelegate

2. Install dependencies

```
pod install
```

2. Run the app

You will see the anonymous id will be set only once when app is restarted.

3. Logout

If you want to reset, tap `Logout` button, this will set new UUID upon starting.

**IMPORTANT**

In order to have different anonymousId on logout operation, set new `anonymousId` before resetting

```
// We should resetting anonymous id before resetting
NSString *newUUID =[NSUUID UUID].UUIDString;
[RSClient setAnonymousId: newUUID];

    
[[RSClient sharedInstance] reset];
```

## Initialisation

Make sure you set the `setAnonymousIdOnce` on AppDelegate, before setting the `writeKey`

`setAnonymousIdOnce` will make sure anonymousId will be the same at first time the app initialised until the app is logged out.

```
NSURL *dataPlaneUrl = [NSURL URLWithString:@"https://dataplane.url"];
NSString *writeKey = @"...";
NSString *newUUID = [NSUUID UUID].UUIDString;

[RSClient setAnonymousIdOnce:newUUID];

RSConfigBuilder *builder = [[RSConfigBuilder alloc]init];
[builder withDataPlaneURL:dataPlaneUrl];
[builder withControlPlaneURL:dataPlaneUrl];
[builder withLoglevel:RSLogLevelDebug];
[RSClient getInstance:writeKey config:[builder build]];
```

## Track and Identify 

Then on your part of your app you can track and identify accordingly.

More info on track and identify is [here](https://docs.rudderstack.com/stream-sources/rudderstack-sdk-integration-guides/rudderstack-ios-sdk#track).

