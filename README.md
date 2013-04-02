# PsychAnalyzer

PsychAnalyzer creates a psychological profile of any content given based on provided dictionary contains the categories and its keywords that fits with your needs.

## Installation

Add this line to your application's Gemfile:

    gem 'psych_analyzer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install psych_analyzer

## Usage
Get started with the following steps:

    $ irb
    irb(main):001:0> require 'psych_analyzer'
    => true
    irb(main):002:0> paths = {"dictionary" => "psych_dictionary.csv", "ignored_keywords" => "ignored_keywords.csv"}
    => {"dictionary"=>"psych_dictionary.csv", "ignored_keywords"=>"ignored_keywords.csv"}
    irb(main):003:0> input = ["I love this car.","This view is amazing.","I feel great this morning.","I am so excited about the concert.","He is my best friend.","I do not like this car.","This view is horrible.","I feel tired this morning.","I am not looking forward to the concert.","He is my enemy.", "that is so good"]
    => ["I love this car.", "This view is amazing.", "I feel great this morning.", "I am so excited about the concert.", "He is my best friend.", "I do not like this car.", "This view is horrible.", "I feel tired this morning.", "I am not looking forward to the concert.", "He is my enemy.", "that is so good"]
    irb(main):004:0> PsychAnalyzer.train paths
    => true
    irb(main):005:0> PsychAnalyzer.analyze input
    => {"positive"=>63.64, "negative"=>36.36}



## Contributing

Please see CONTRIBUTING.md for details.

## Credits

psych_analyzer was originally written by Ramy Khater.

![RSM](http://rayasocialmedia.com/images/logo.png)

psych_analyzer is maintained and funded by Raya Social Media.

## License
psych_analyzer is Copyright © 2013 Raya Social Media. It is free software, and may be redistributed under the terms specified in the LICENSE file.