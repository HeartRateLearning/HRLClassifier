Pod::Spec.new do |s|
  s.name             = 'HRLClassifier'
  s.version          = '3.0.2'
  s.summary          = '(DEPRECATED) Use Machine Learning to predict if a person is working out based of his/her heart rate.'

  s.description      = <<-DESC
(DEPRECATED) Use Machine Learning to predict if a person is working out based of his/her heart rate.
                       DESC

  s.homepage         = 'https://github.com/HeartRateLearning/HRLClassifier'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Enrique de la Torre' => 'indisoluble_dev@me.com' }
  s.source           = { :git => 'https://github.com/HeartRateLearning/HRLClassifier.git', :tag => s.version.to_s }

  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.source_files = 'HRLClassifier/Classes/**/*'

  s.dependency 'HRLAlgorithms', '~> 1.0'
end

