# HRLClassifier

[![CI Status](https://travis-ci.org/HeartRateLearning/HRLClassifier.svg?branch=master)](https://travis-ci.org/HeartRateLearning/HRLClassifier)
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

let filename = "/path/to/archive"

let baseDate = Date(timeIntervalSinceReferenceDate: 0)
let dayInterval = 24 * 60 * 60
let maxBPM = 200

// Fill data frame
var auxDataFrame = NSKeyedUnarchiver.unarchiveObject(withFile: filename) as? DataFrame
if auxDataFrame == nil {
    auxDataFrame = DataFrame()

    for i in 0..<7 {
        for _ in 0..<80 {
            let timeInterval = i * dayInterval + Int(arc4random_uniform(UInt32(dayInterval)))

            let date = baseDate.addingTimeInterval(TimeInterval(timeInterval))
            let bpm = Float(arc4random_uniform(UInt32(maxBPM)))
            let record = Record(date: date, bpm: bpm)

            let isWorkingOut = arc4random_uniform(2) == 1 ? true : false

            auxDataFrame!.append(record: record, isWorkingOut: isWorkingOut)
        }
    }
}

let dataFrame = auxDataFrame!

// Make classifier
guard let classifier = try? ClassifierFactory().makeClassifier(with: dataFrame) else {
    print("Given that all records are created in a random fashion, this is expected")

    return
}

// Archive data frame
NSKeyedArchiver.archiveRootObject(dataFrame, toFile: filename)

// Predict
let date = baseDate.addingTimeInterval(TimeInterval(7 * dayInterval))
let bpm = Float(arc4random_uniform(UInt32(maxBPM)))
let record = Record(date: date, bpm: bpm)

let prediction = classifier.predictedWorkingOut(for: record)

print("At \(date) with \(bpm) bpm, is user working out? \(prediction)")
```

## License

HRLClassifier is available under the MIT license. See the LICENSE file for more info.
