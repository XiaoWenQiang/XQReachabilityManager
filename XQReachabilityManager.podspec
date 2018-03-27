Pod::Spec.new do |s|

s.name     = "XQCategory"
s.version  = "1.0.0"
s.license  = "MIT"
s.summary  = "一个实用的判断网络的状况的类"
s.homepage = "https://github.com/XiaoWenQiang/XQReachabilityManager.git"
s.author   = { "xiaoqiang" => "xiaowenqiang_1@126.com" }
s.social_media_url = "https://www.jianshu.com/u/16227d25bcf4"
s.source       = { :git => "https://github.com/XiaoWenQiang/XQReachabilityManager.git", :tag => "1.0.0" }
s.description = %{
一个实用的判断网络的状况的类。
}
s.source_files = "XQReachabilityManager","XQReachabilityManager/*.{h,m}"
s.frameworks = 'Foundation', 'UIKit'，
s.requires_arc = true
s.platform = :ios, '8.0'
s.dependency "Reachability"
end
