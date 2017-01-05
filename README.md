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
import HRLClassifier

let baseDate = Date(timeIntervalSinceReferenceDate: 0)
let dayInterval = 24 * 60 * 60
let maxBPM = 200

// Add training data
let classifier = Classifier()

for i in 0..<7 {
    for _ in 0..<Classifier.Constants.minRecordsPerWeekday {
        let timeInterval = i * dayInterval + Int(arc4random_uniform(UInt32(dayInterval)))

        let date = baseDate.addingTimeInterval(TimeInterval(timeInterval))
        let bpm = Float(arc4random_uniform(UInt32(maxBPM)))
        let record = Record(date: date, bpm: bpm)

        let isWorkingOut = arc4random_uniform(2) == 1 ? true : false

        classifier.add(trainingData: (record: record, isWorkingOut: isWorkingOut))
    }
}

// Train classifier
classifier.train()

// Deploy classifier
classifier.deploy()

// Predict
let date = baseDate.addingTimeInterval(TimeInterval(7 * dayInterval))
let bpm = Float(arc4random_uniform(UInt32(maxBPM)))
let record = Record(date: date, bpm: bpm)

let prediction = classifier.predictedWorkingOut(for: record)

print("At \(date) with \(bpm) bpm, is user working out? \(prediction)")
```

## License

HRLClassifier is available under the MIT license. See the LICENSE file for more info.

