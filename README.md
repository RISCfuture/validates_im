validates_im
============

**Instant messenger account validations for ActiveRecord**

|             |                                 |
|:------------|:--------------------------------|
| **Author**  | Tim Morgan                      |
| **Version** | 1.1 (Aug 31, 2011)              |
| **License** | Released under the MIT license. |

About
-----

`validates_im` is a simple gem that gives you some `EachValidators` that you can
use to validate instant messenger account names in your Rails 3.0 application.
Validators are provided for the most common IM services, like AIM, Yahoo! IM,
and Skype.

Installation
------------

**Important Note:** This gem is for Rails+ 3 only.

To install, simply add this gem to your Rails project's @Gemfile@:

```` ruby
gem "validates_im"
````

Usage
-----

The IM validators are `EachValidators`, meant to be used with the `validates`
method. An example:

```` ruby
validates :screen_name,
          aim:      true,
          presence: true
````

The name of the symbol key is taken from the name of the validator; as such, The
`XboxLiveValidator` would be invoked using `:xbox_live`. See the
{AccountNameValidator} class docs for more information.

The localization keys for validation errors are listed in the documentation for
each validator class.
