# DeveloperChallenge

## Installation

Clone the repository, then execute

    $ gem build developer_challenge.gemspec

    $ gem install developer_challenge-1.0.gem

Run tests with 

    $ rake

## Notes

This was fun - haven't packaged up a gem or done concurrency in Ruby before.

The slowapi solution needs some work. Not sure what best practices are with this kind of thing - was considering grabbing hundreds of native threads to speed it up (it's set to 8), but that seems questionable. I think the good route would be Fibers and EventMachine.

The minimum path sum will fail if it can't fit the triangle in memory, but the algorithm would be easy to adapt - we could read individual numbers from the file one at a time, and write the working sum (only ever as big as one row) to disk as it's calculated.
