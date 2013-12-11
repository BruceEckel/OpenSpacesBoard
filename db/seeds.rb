# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'date'
locations = [
    'PH Downstairs',
    'PH Stained Glass',
    'PH Piano',
    'Rumors',
    "Bruce's House",
    'Posse House',
]
# Might also want to include things like lightning talks and other 'all' events so they will somehow
# show up; then the app becomes the central "calendar" for what's going on (not necessarily skiing meetups etc.)
# Create session as an object to simplify configuration?
sessions = [
    [ 'Session 1', DateTime.parse('2014-2-24 9:30'), DateTime.parse('2014-2-24 10:30') ],
    [ 'Session 2', DateTime.parse('2014-2-24 11:00'), DateTime.parse('2014-2-24 12:00') ],
    [ 'Workshop 1', DateTime.parse('2014-2-24 2:00 PM'), DateTime.parse('2014-2-24 5:30 PM') ],
    [ 'Session 3', DateTime.parse('2014-2-25 8:30'), DateTime.parse('2014-2-25 9:30') ],
    [ 'Session 4', DateTime.parse('2014-2-25 10:00'), DateTime.parse('2014-2-25 11:00') ],
    [ 'Session 5', DateTime.parse('2014-2-25 11:30'), DateTime.parse('2014-2-25 12:30') ],
    [ 'Workshop 2', DateTime.parse('2014-2-25 2:00 PM'), DateTime.parse('2014-2-25 5:30 PM') ],
    [ 'Hackathon', DateTime.parse('2014-2-26 9:00'), DateTime.parse('2014-2-26 5:30 PM') ],
    [ 'Session 6', DateTime.parse('2014-2-27 8:30'), DateTime.parse('2014-2-27 9:30') ],
    [ 'Session 7', DateTime.parse('2014-2-27 10:00'), DateTime.parse('2014-2-27 11:00') ],
    [ 'Session 8', DateTime.parse('2014-2-27 11:30'), DateTime.parse('2014-2-27 12:30') ],
    [ 'Workshop 3', DateTime.parse('2014-2-27 2:00 PM'), DateTime.parse('2014-2-27 5:30 PM') ],
    [ 'Session 9', DateTime.parse('2014-2-28 8:30'), DateTime.parse('2014-2-28 9:30') ],
    [ 'Session 10', DateTime.parse('2014-2-28 10:00'), DateTime.parse('2014-2-28 11:00') ],
    [ 'Session 11', DateTime.parse('2014-2-28 11:30'), DateTime.parse('2014-2-28 12:30') ],
    [ 'Workshop 4', DateTime.parse('2014-2-28 2:00 PM'), DateTime.parse('2014-2-28 5:30 PM') ],
]