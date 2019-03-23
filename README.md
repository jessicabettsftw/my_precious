# Precious

I wanted to make a fun programming language so I did it.
It's all my own, my precious... Precious is a LOTR esoteric programming language translator.
Precious uses lore keywords and english to create simple programming functionality.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'precious'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install precious

## Syntax:
Welcome to the Fellowship!

the my_precious gem is designed to find and hold on to keywords and ignore everything else.
this allows users to create their own stories in the Precious language that is then translated to valid Ruby code.

each piece of code you write in Precious must be written on its own new line in your text editor of choice.

now, in the words of Gandalf the Gray, “All we have to decide is what to do with the time that is given us.” 

# known bugs
version 0.2.3 - the last character of the function name will be removed.

`transcribe the book about Mordor with Nazgul, Frodo

def mordo( nazgul, frodo )`

# variables
use capitols

Frodo is 8 years old

# strings
use double quotes

Frodo is "a hobbit"

# integers
write normally

Orcs are 2 big

# commenting
use the keywords: 'second breakfast', 'wear the ring'

`i love second breakfast Sam is going to be a number`
`wear the ring Frodo`

everything that comes after 'second breakfast' will be commented out.
everything before 'second breakfast' will not.

# puts
use the keywords: 'bring forth the ring', 'says', 'screams', 'exclaims', 'sobbs' or 'coughs'

`bring forth the ring Frodo`
`gandalf says "they're taking the hobbits to Isengard"`

# assignment
use the keywords: 'is', 'has', 'are'

`Frodo is 8`
`Elves are worried when they saw 7 hobbits approaching the lair`

# increment
use the keywords: 'eats lembas bread', 'fortifies stronghold', 'rests', 'recieves Evenstar' or 'reforges Narsil'

`Frodo eats lembas bread`

# decrement
use the keywords: 'runs out of lembas bread', 'lost' or 'hunted by orcs'

`Sam runs out of lembas bread`
`Pippin gets hunted by orcs`

# addition
use the keywords: 'joins', 'and' or 'accompanies'

Frodo joins the fellowship with a Nazgul
Gollum and Frodo went inside mordor

# subtraction
use the keywords: 'leaves the fellowship', 'stabs', 'banishes' or 'steals'

Sam leaves the fellowship without telling Sam
a Wraith accidentally stabs Sauron in the face at a really important business meeting

# multiplication
use the keywords: 'gives aid to', 'procreates' or 'bolsters'

Arigorn bolsters Helmsdeep

# division
use the keywords: 'decapitates' or 'dismembers'

Gimly dismembers Legolas

# true
use the keywords: 'precious'

Legolas is precious

#negation
use keywords: 'not'

the Balrog is not precious

# loops
use the keywords: 'whilst' or 'during the journey'

whilst Frodo climed as strong as he could, Saruman cried, nooo!!

# comparisons
use keywords: 'equal', 'same' or 'similar'

Gollum can be the same as Smeagol

# greater/less than
use keywords: 'stronger than' or 'more' and 'weaker than' or 'less'

Bilbo ate more tree food than Treebeard

# conditionals
use keywords: 'does', 'if' or 'will'

will Mary equal Pippin?

# end
use keywords: 'you shall not pass'

you shall not pass

#defining a function
use keywords: 'transcribe' or 'tell a story'

transcribe the book about Mordor

#calling a function
use keywords: "theyre taking the hobbits to"

they are taking the hobbits to Mordor

#establishing parameters
use keywords: 'with'

they are taking the hobbits to Mordor with Nazgul, Frodo

everything after the keyword 'with' is a parameter. use a ',' or ' ' to separate parameters

#class words
use keywords: 'chapter :'

chapter : TheMines

the format here is important. everything after the ':' will be considered a classname.
classnames must be capitalized

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/<github username>/precious. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Precious project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/<github username>/precious/blob/master/CODE_OF_CONDUCT.md).