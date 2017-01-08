# Microsoft Cognitive Services Face for Ruby

Detect human faces and compare similar ones, organize people into groups according to visual similarity, and identify previously tagged people in images

https://www.microsoft.com/cognitive-services/en-us/face-api

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'microsoft-cognitive-face'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install microsoft-cognitive-face

## Usage

```ruby 
  client = Cognitive::Face::Client.new key: 'MICROSOFT_FACE_KEY'
```

Face - Detect

https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395236

```ruby 
  face = client.detect File.read('dhh.png')
  # => #<OpenStruct faceId="6c6a4eea-795f-4ab8-92d2-a99735af6f31", faceRectangle={"top"=>153, "left"=>98, "width"=>203, "height"=>203}>
```

Face List - Create a Face List

https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f3039524b

```ruby 
 secure_face_list_id = SecureRandom.uuid
 face_list = client.create_face_list(
  name: 'Ruby test',
  face_list_id: secure_face_list_id
 )
 #=> true
```

Face List - Add a Face to a Face List

https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395250

```ruby 
  face = face_client.add_face_to_face_list(
    face: File.read('dhh.jpg'),
    face_list_id: secure_face_list_id
  )
  #=> #<OpenStruct persistedFaceId="d91bc779-66ac-4fa6-a4e2-62552c3f5404">

```



Face - Find Similar

https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395237

```ruby
  face_client.find_similar(
      face_list_id: secure_face_list_id,
      face_id: 'd91bc779-66ac-4fa6-a4e2-62552c3f5404'
  )
  # => [#<OpenStruct persistedFaceId="47e5313c-efb6-47f4-ab3e-80b71b2ba381", confidence=1.0>]

```


Face List - Delete a Face from a Face List

https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f30395251

```ruby
  face_client.delete_face_to_face_list(
    face_id: 'd91bc779-66ac-4fa6-a4e2-62552c3f5404',
    face_list_id: secure_face_list_id
  )
  # => true
```


Face List - Delete a Face List

https://dev.projectoxford.ai/docs/services/563879b61984550e40cbbe8d/operations/563879b61984550f3039524f



```ruby
  face_client.delete_face_list(
    face_list_id: secure_face_list_id
  )
  # => true
```





## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `MICROSOFT_FACE_KEY=APIKEY rake spec ` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jdaviderb/microsoft-cognitive-face-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

