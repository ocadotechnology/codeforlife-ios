# Blockly

[![Version](https://img.shields.io/cocoapods/v/Blockly.svg?style=flat)](http://cocoapods.org/pods/Blockly)
[![License](https://img.shields.io/cocoapods/l/Blockly.svg?style=flat)](http://cocoapods.org/pods/Blockly)
[![Platform](https://img.shields.io/cocoapods/p/Blockly.svg?style=flat)](http://cocoapods.org/pods/Blockly)

## Introduction
Inspired Google developer library, [Blockly](!https://developers.google.com/blockly/?hl=en), this is an similar blockly framework for the iOS platform: a visual programming platform for people to code using blocks. This library is structured in a really similar way to the Google library aiming for easy pick up when people want to achieve similar design in iOS.

## Usage

All the pod files are included in the repository hence it is not necessary to run `pod install`. Simply clone the project and open `PATH_TO_REPO/blockly-ios/Example/Blockly.xcworkspace` and run the application.

## Requirements

* Deployment Target: iOS 8.3+
* Language: Swift 1.2+

## Installation

Blockly is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Blockly"
```

## Blockly Structure

The official Google blockly website has a thorough documentation of the blockly structure which you are highly recommended to read through. Althought UI-wise the structures are very similar, in terms of implementation, there are some differences between the two libraries.

### Blockly Interface:

Blockly can be imagined as an 2D object. An object itself is called a blockly (Trivial!!!). Each row of a blockly is called an `Input`. Each `Input` can be considered as an array, which the number of element is not limited and each element is called a `Field`.

#### Input

`Inputs` can be divided into 3 categories: `Dummy`, `Value`, and `Statement`. `DummyInput` does not take any input, it aims to provide a row to displace static text. For example,

##### Dummy Input

![alt text](/Documentation/Images/input1.png)

Snap! is an expression to show excitement! It does not require an argument to make it a full sentence! However it does require a space to display 'Snap!', hence we need a dummy row to display static text

##### Value Input

![alt text](/Documentation/Images/input2.png)

Who you are is decided by you! Clearly you will never want to be the same boring person for the whole time so you don't want a dummy input like that! Bruce Wayne is smart. Apart from being a billionaire, he can also be Batman!

![alt text](/Documentation/Images/input3.png)
![alt text](/Documentation/Images/input4.png)

##### Statement Input

Statement Input, similar to `Value Input`, but takes a statement as argument instead.

![alt text](/Documentation/Images/input5.png)

#### Field

Fields are building blocks of an Input. Under current implementation, there are only two type of fields.

##### Normal Field

![alt text](/Documentation/Images/field1.png)

Normal fields are used to display static text.

##### Field Text Input

![alt text](/Documentation/Images/field2.png)

`FieldTextInput`s are used to display a text field and allow user to edit the content of the text field.

### Blockly Implementation
A better refactoring is still in progress. The ultimate goal is to seperate the Blockly UI Interface from the Blockly logic completely so users are free to implement their own UI.

![alt text](/Documentation/Images/blockly_implementation.png)

Each `Blockly` has optionally `previousConnection`, `nextConnection`, `outputConnection`, and `inputConnections`, which is a list of `InputConnection`. It also consists of a list of `String` arguments, `args`, to represent any variables or constants declared in that core.

#### Connection
`Connection` helps to establish the linkage between two `Blockly`s but a `Blockly` does not establish a relationship with another `Blockly` by linking themselves to the same `Connection`. Instead, the process is carried out like the following:

![alt text](/Documentation/Images/connection_mechanism.png)

#### Communications between BlocklyUI and BlocklyCore
Try to avoid any direct linkage between UI components and logic components. Ideally, a double linkage should only be allowed between `UIBlocklyView` and `Blockly` with `Blockly` interacting with `UIBlocklyView` using a delegate protocol manner. However, the framework in this version still consists heavy depencies between the two parties. You are not recommended to massively change the UI.

## Customization
Blockly-iOS is designed to be easy-customizable.
These are the currently available customizations:
* `setPreviousStatement(enable: Bool) // Default true`
* `setPreviousStatement` decides if a blockly can have another blockly attached to its front

![alt text](/Documentation/Images/customization1.png)

* `setNextStatement(enable: Bool) // Default true`
* `setNextStatement` decides if a blockly can have another blockly attached to its back

![alt text](/Documentation/Images/customization2.png)

* `setOutput(type: InputType) // Optionals`
* `setOutput` indicates a blockly has the functionality to output a value, which can be paired with other blocklys if they have an input to accept an argument
* `InputType` indicates the type of the output value (e.g. `Boolean`, `Integer`, `String`), this argument is not optional

![alt text](/Documentation/Images/customization3.png)

![alt text](/Documentation/Images/customization4.png)

* `addDummyInput()`
* `addValueInput()`
* `addStatementInput()`

## License

Blockly is available under the MIT license. See the LICENSE file for more info.
