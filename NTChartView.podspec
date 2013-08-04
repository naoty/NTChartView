Pod::Spec.new do |s|
  s.name         = "NTChartView"
  s.version      = "0.0.1"
  s.summary      = "Easily charting library"
  s.homepage     = "http://github.com/naoty/NTChartView"
  s.license      = { type: "MIT", file: "LICENSE" }
  s.author       = { "Naoto Kaneko" => "naoty.k@gmail.com" }
  s.source       = { git: "http://github.com/naoty/NTChartView.git", tag: "v#{s.version}" }
  s.source_files = "NTChartView/**/*.{h,m}"
  s.framework    = "QuartzCore"
  s.requires_arc = true
end
