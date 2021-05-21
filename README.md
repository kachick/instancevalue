instancevalue
=============

* ***This repository is archived***
* ***No longer maintained***
* ***All versions have been yanked from https://rubygems.org for releasing valuable namespace for others***

[I still want these feature in Ruby...](https://github.com/kachick/instancevalue/issues/3)

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

* Require Ruby 2.3.3 or later

License
--------

The MIT X11 License
Copyright (c) 2012 Kenichi Kamiya
See MIT-LICENSE for further details.
