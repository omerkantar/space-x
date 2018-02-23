# Uncomment the next line to define a global platform for your project
platform :ios, '9.3'
use_frameworks!

def all_pods
  pod 'Moya', '~> 11.0'
  pod 'ObjectMapper', '~> 3.1'
  pod 'AlamofireImage', '~> 3.3'
end

target 'spacex' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  all_pods

  target 'spacexTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'spacexUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
