Pod::Spec.new do |s|
  s.name             = 'HRLClassifier'
  s.version          = '0.2.0'
  s.summary          = 'Use Machine Learning to predict if a person is working out based of his/her heart rate.'

  s.description      = <<-DESC
Use Machine Learning to predict if a person is working out based of his/her heart rate.
                       DESC

  s.homepage         = 'https://github.com/HeartRateLearning/HRLClassifier'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Enrique de la Torre' => 'indisoluble_dev@me.com' }
  s.source           = { :git => 'https://github.com/HeartRateLearning/HRLClassifier.git', :tag => s.version.to_s }

  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.source_files = 'HRLClassifier/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'

  s.dependency 'HRLAlgorithms', '~> 0.1'
end

