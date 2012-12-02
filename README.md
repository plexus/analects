analects.rb
===========

Public datasets on the Chinese language, accessible from Ruby

This is a work in progress. At the moment it contains
 * A class for easily downloading and processing CC-CEDICT
 * A Rails 3 generator that create migrations and a model for importing and using CC-CEDICT in your applications

In you Gemfile

    gem 'analects', :git => 'git@github.com:arnebrasseur/analects.git'

Then

    rails g analects:cedict

Then

    rake db:migrate

That's all folks.

All code (c) Arne Brasseur, 2012. Analects is released under the MIT License (http://www.opensource.org/licenses/mit-license.php).
