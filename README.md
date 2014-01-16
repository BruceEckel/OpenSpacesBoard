OpenSpaces Board
================

Moving the session board from physical to virtual space!

* Web-based for phones, tablets and computers

* Instant updates to all users when a new session is posted

* Sessions can now be distributed across multiple buildings

* Conference can expand without changing to a larger location

Installation Instructions
------------------
If you want to help out with development or just get the project running on your own hardware, here's
the basic process for setting it up.

We've been developing using Ruby 1.9.3 and Rails 4.0.2

1. Install Ruby and Ruby Gems (this process will vary depending on platform)
2. Install Postgresql (This will vary by platform)
3. Create a Postgres database called open_spaces_board_development, with a username 'postgres' and password 'fibble'
4. Install Rails
```
gem install rails
```
5. Clone this repo down somewhere on your development box and cd into the directory
6. Run
```
bundle install
```
within your cloned repo
8. Run 
```
rake db:migrate
```
followed by 
```
rake db:seed
```
7. Finally, run 
```
rails s
```
to start up the server, and visit localhost:3000 in your browser.


