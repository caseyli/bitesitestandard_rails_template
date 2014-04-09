bitesitestandard_rails_template
===============================


Usage
=====

To use, simply clone this code, and run

    rails new my_app -m bitesitestandard_rails_template/template_auto.rb

Or if you want to disable some features, you can run the interactive version

    rails new my_app -m bitesitestandard_rails_template/template_i.rb


Description
===========

Rails Application Template for standard BiteSites (includes Email setup, Devise, Roles, Signed in Bar).

This application template adds a few things not standard in rails new:

E-mail Setup
------------

This adds letter_opener to the development.rb and smtp Gmail setup for the production.rb.

Devise and Roles Setup
----------------------

Includes devise along with Role model creation, and corresponding views.
