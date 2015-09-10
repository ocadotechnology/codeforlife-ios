# codeforlife-ios

##### Table of Contents

1. [Design Structure](#design_structure)
  1. [View Controllers and Delegates](#view_controllers_and_delegates)
  2. [Request](#request)
    1. [Framework](#request_framework)
    2. [Structure](#request_structure)
  3. [Animation](#animation)
  4. [GameScene](#game_scene)
2. [Testing](#testing)
  1. [KIF](#kif)
  2. [Quick](#quick)
  3. [XCTest](#xctest)
3. [FAQ](#faq)


<a name="design_structure"/>
## Design Structure

<a name="view_controllers_and_delegates"/>
### View Controllers and Delegates
Each view controller has its own delegate. In the current implementation, ```GameViewControllerDelegate``` is a concrete delegate which implements all the delegate protocols for other view controllers.

![Relationship between View Controllers and Delegates](/Documentation/img/ViewControllerAndDelegates.png)

When adding functionality for each view controllers, try to extend the content in the delegate instead of creating dependency between view controllers. This will allow easier addition of new features.

<a name="request"/>
### Request


<a name="request_framework"/>
#### Framework
HTTP Networking requests are handled by [Alamofire](https://github.com/Alamofire/Alamofire), a Swift framework recommended by a Obj-C framework, [AFNetworking](https://github.com/AFNetworking/AFNetworking), to people who seek for a Swift althernative of AFNetworking. It handles both synchronous and asynchronous requests neatly with easily-understandable syntax.

<a name="request_structure"/>
#### Structure
A concrete `Request` class must contains :

1.  Url of the request(Be it for development or deployment)
2.  Http method
3.  List of parameters
4.  ```Mode```(A class which identifies whether the application is testing using MockDelegates, in development, or in deployment)
5.  ```execute(callback: (() -> Void)?)```, a function which indicates what to perform under different ```Mode```
6.  ```processData(dada: NSData)```, a function to handle the data processing after results are fetched. (N.B. the data are mostly in JSON format)

<a name="animation"/>
### Animation
The game currently does not have its own game logic to check result. Game logic checking is instead handled by communicating with the web version of the game via javascript. By using `Webkit`, with a specific parameter in the url, javascript will return a json string to be analysed. The analysis is handled by `GameViewInteractionHandler`, which will translate the JSON to an `[[Animation]]` instance. This object is then passed to a `AnimationHandler` instance to execute the animations.

An `Animation` is nothing more than an object containing an action(or a set of actions). However most actions have been refactored to become delegate functions in corresponding view controller delegates.

<a name="game_scene"/>
### GameScene
All the media files are originated from the web version, images in SVG format, audios in mp3 format. SVGs are not supported by XCode, although there exists a pod called SVGKit, exporting the images to png format makes it much easier to configure.

SpriteKit is an framework which is supposed to replace SceneKit, both are graphic rendering frameworks for iOS. Without deep understanding about SceneKit, hardly can I comment on the advantages or disadvantages of them. SpriteKit was chosenly solely on the reason that SpriteKit is newer and seems more sophisticated.

GameMapViewController displays a MapScene which contains a `WorldNode`(i.e an `SKNode` representing the 'World') and the `WorldNode` contains a `CameraNode`(i.e. another `SKNode` which represent the camera, deciding which part of the world to show on screen)

Try to avoid temperting classes under `GameScenes/Objects`, especially the superclass and `Roads`. To fit the images from the web version of the game, a lot of magic numbers have been include to tweak the map so as to display the corrent items at almost correct positions.


<a name="testing"/>
## Testing
This project was created when Swift 1.2 was the latest stable version, which does not contain a UI testing tool. Several testing frameworks had been included in this project to provide both unit tests and UI tests.

<a name="kif"/>
### [KIF](https://github.com/kif-framework/KIF)
Once again, KIF was picked because Swift 2 was still not stable at the stage of the production of this application. Swift 2 provides a UITest tool which may surpass KIT. Currently KIF focuses sole on UITest which make you difficult to check variables which cannot be accessed by accessibility label. That aside, funtionality includes asynchronous task handling which makes it a pretty neat tool to test the UI.

<a name="quick"/>
### [Quick](https://github.com/Quick/Quick)
This framework also include another framework, called [Nimble](https://github.com/Quick/Nimble). Introduction on Quick briefly explains its advantage over XCTest in terms of readability which is the main reason to be chosen over XCTest.

<a name="xctest"/>
### XCTest
The original testing framework introduced by Apple is mainly used for testing struct. While it is not as human-readable as Quick, this framework comes in handy when it comes to basic struct tests. Reason behind is that for Quick to compare equality, one class must implement equatable and struct cannot inherit any class, this leaves the code to become this style

```
expect(Coordinates(1.2)).to(BeEqual(Coordinates(1,2))     // Does not compile, Coordinates does not inherit equatable
expect(Coordinates(1,2) == Coordinates(1,2)).to(BeTrue()) // Compile, but not as readable as the above one
```

<a name="faq"/>
##FAQ - Common Problems encountered

##### When running unit test with ```XCTest```, the test crash saying it cannot cast certain view controller from ```codeforlife-ios._viewController``` to ```codeforlife-iosTests._viewController```


In Swift 1.1: Instantiating view controller from Storyboard can be achieved by the following code
````Swift
let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
let viewController = storyboard.instantiateInitialViewController() as! LaunchScreenViewController
````
Make sure you use ```NSBundle.mainBundle()``` instead of ```nil```
Also make sure in that view controller class, include ```codeforlife-iosTests``` as a target
Another way is to use the method below

In Swift 1.2(works in Swift 1.1 as well): Apple has introduced a tighten access control rules to follow.
Above code will produce runtime errors about difficulty casting one class to another. Solution follows:

1. *Exclude* viewcontroller as a target for ```codeforlife-iosTests```
2. Declare the class to be tested public

N.B. If you have to change certain private variables to public just for the sake of testing, that is code smell. Refactor until you no longer EVEN think about testing a private function

##### Compiler Error: XCTest Library not loaded in `codefoelife-ios`
Make sure in the pod file, all libraries (e.g. `KIF` and `Quick`) which depend on `XCTest` are only targeting `codeforlife-iosTests` instead of both `codeforlife-iosTest` and `codeforlife-ios`.

```
//pods do not require XCT go here
target 'codeforlife-iosTests' do
    //pods require XCTest go here
end
```

The compiler is trying to include those libraries in `codeforlife-ios` but `XCTest` is not include `codeforlife-ios` hence the error.
