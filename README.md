# codeforlife-ios

## Design Structure

### Gameflow

### View Controllers and Delegates

### Request

### Animation

### GameScene
All the media files are originated from the web version, images in SVG format, audios in mp3 format. SVGs are not supported by XCode, although there exists a pod called SVGKit, exporting the images to png format makes it much easier to configure.

SpriteKit is an framework which is supposed to replace SceneKit, both are graphic rendering frameworks for iOS. Without deep understanding about SceneKit, hardly can I comment on the advantages or disadvantages of them. SpriteKit was chosenly solely on the reason that SpriteKit is newer and seems more sophisticated.

GameMapViewController displays a MapScene which contains a ```WorldNode```(i.e an ```SKNode``` representing the 'World') and the ```WorldNode``` contains a ```CameraNode```(i.e. another ```SKNode``` which rep

## Testing
This project was created when Swift 1.2 was the latest stable version, which does not contain a UI testing tool. Several testing frameworks had been included in this project to provide both unit tests and UI tests.

### KIF
Once again, KIF was picked because Swift 2 was still not stable at the stage of the production of this application. Swift 2 provides a UITest tool which may surpass KIT. Currently KIF focuses sole on UITest which make you difficult to check variables which cannot be accessed by accessibility label. That aside, funtionality includes asynchronous task handling which makes it a pretty neat tool to test the UI.

### Quick
This framework also include another framework, called Nimble. Introduction on Quick briefly explains its advantage over XCTest in terms of readability which is the main reason to be chosen over XCTest.

### XCTest
The original testing framework introduced by Apple is mainly used for testing struct. While it is not as human-readable as Quick, this framework comes in handy when it comes to basic struct tests. Reason behind is that for Quick to compare equality, one class must implement equatable and struct cannot inherit any class, this leaves the code to become this style
```
struct Coordinates {
  let x: Int
  let y: Int
  
  init(x: Int, y:Int) {
    self.x = x
    self.y = y
  }
  ...
}
expect(Coordinates(1.2)).to(BeEqual(Coordinates(1,2))     // Does not compile, Coordinates does not inherit equatable
expect(Coordinates(1,2) == Coordinates(1,2)).to(BeTrue()) // Compile, but not as readable as the above one
```
