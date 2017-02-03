instancevalue
=============

[![Build Status](https://secure.travis-ci.org/kachick/instancevalue.png)](http://travis-ci.org/kachick/instancevalue)
[![Gem Version](https://badge.fury.io/rb/instancevalue.png)](http://badge.fury.io/rb/instancevalue)

Description
-----------

Constant values for each instance.

Features
--------

### instance_variable like API

* .value_reader
* #instance_value_defined?
* #instance_value_get
* #instance_value_set
* #instance_values
* #remove_instance_value

### Aliased shortname

* #val

Usage
-----

```ruby
require 'instancevalue'

class Person

  include InstanceValue

  value_reader :birthday

  def initialize(birthday)
    val :birthday, birthday
  end

  def age
    (Time.now - birthday) / (60 * 60 * 24 * 365)
  end

end

person = Person.new Time.at YOUR_BIRTHDAY
person.birthday                                 #=> YOUR_BIRTHDAY
person.age                                      #=> age at runtime
person.instance_eval{val :birthday, Time.now}   #=> Exception
```

Requirements
-------------

* Expect Ruby 2.3.3 or later

Install
-------

```shell
gem install instancevalue
```

Development
----

```shell
bundle exec rake
```

Link
----

* [Home](http://kachick.github.com/instancevalue/)
* [code](https://github.com/kachick/instancevalue)
* [API](http://kachick.github.com/instancevalue/yard/frames.html)
* [issues](https://github.com/kachick/instancevalue/issues)
* [CI](http://travis-ci.org/#!/kachick/instancevalue)
* [gem](https://rubygems.org/gems/instancevalue)

License
--------

The MIT X11 License
Copyright (c) 2012 Kenichi Kamiya
See MIT-LICENSE for further details.
