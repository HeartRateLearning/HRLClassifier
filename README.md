# HRLClassifier

[![CI Status](http://img.shields.io/travis/HeartRateLearning/HRLClassifier.svg?style=flat)](https://travis-ci.org/HeartRateLearning/HRLClassifier)
[![codecov.io](https://codecov.io/github/HeartRateLearning/HRLClassifier/coverage.svg?branch=master)](https://codecov.io/github/HeartRateLearning/HRLClassifier?branch=master)
[![Version](https://img.shields.io/cocoapods/v/HRLClassifier.svg?style=flat)](http://cocoapods.org/pods/HRLClassifier)

Use Machine Learning to predict if a person is working out based of his/her heart rate.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

HRLClassifier is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HRLClassifier"
```

## Usage

```swift
let date = Date()

let dataFrame = DataFrame()
dataFrame.append(record: Record(date:date.addingTimeInterval(-6 * 60 * 60),
                                bpm:Float(100)),
                 isWorkingOut: false)
dataFrame.append(record: Record(date:date.addingTimeInterval(-5 * 60 * 60),
                                bpm:Float(140)),
                 isWorkingOut: true)
dataFrame.append(record: Record(date:date.addingTimeInterval(-4 * 60 * 60),
                                bpm:Float(120)),
                 isWorkingOut: true)
dataFrame.append(record: Record(date:date.addingTimeInterval(-3 * 60 * 60),
                                bpm:Float(70)),
                 isWorkingOut: false)
dataFrame.append(record: Record(date:date.addingTimeInterval(-2 * 60 * 60),
                                bpm:Float(55)),
                 isWorkingOut: false)
dataFrame.append(record: Record(date:date.addingTimeInterval(-1 * 60 * 60),
                                bpm:Float(125)),
                 isWorkingOut: true)

let classifier = Classifier()
classifier.train(with: dataFrame)

let predictDate = date.addingTimeInterval(-3.5 * 60 * 60)
let predictBPM = Float(130)
let isWorkingOut = classifier.predictedWorkingOut(for: Record(date:predictDate,
                                                              bpm:predictBPM))

print("At \(predictDate) with \(predictBPM) bpm, is user working out? \(isWorkingOut)")
```

## License

HRLClassifier is available under the MIT license. See the LICENSE file for more info.

