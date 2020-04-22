# Openlib

This is a tiny client to the Open Library's [Books API](https://openlibrary.org/dev/docs/api/books). If this client doesn't meet your needs, try the other [Openlibrary client](https://github.com/jayfajardo/openlibrary).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openlib'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install openlib

## Usage

This library will use Openlibrary's *view* or *data* endpoint as appropriate to the requested attribute.  You can access the raw responses with *Book#view* or *Book#data*.

```
> book = Openlib::Book.new(id: '9780316030571')
> book.title
=> "Cryptonomicon"
> book.authors
=> ["Neal Stephenson"]
> book.subjects
=> ["Fiction", "World War, 1939-1945", "World War, 1939-1945 in fiction", "Data encryption (Computer science)", "Cryptography", "Literature", "Science Fiction", "Long Now Manual for Civilization", "Code and cipher stories"]
```

You can query via ISBN, OCLC, LCCN or Openlibrary's OLID.

```
> b = Openlib::Book.new(id: 'OL7360862M', id_kind: :olid)
> b.title
=> "Ranger's Apprentice"
> b.authors
=> ["John Flanagan"]
> b.identifiers
=> {"isbn_13"=>["9780142406632"], "openlibrary"=>["OL7360862M"], "isbn_10"=>["0142406635"], "goodreads"=>["60400"], "librarything"=>["173672"]}
````



## Openlibrary

For more information on Openlibrary, check their [Developer center](https://openlibrary.org/developers) and the [Books API documentation](https://openlibrary.org/dev/docs/api/books).

Openlibrary has a [GitHub](https://github.com/internetarchive/openlibrary) repository.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dkam/openlib.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
