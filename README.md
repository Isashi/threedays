```
██████╗     ██████╗  █████╗ ██╗   ██╗███████╗
╚════██╗    ██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝
 █████╔╝    ██║  ██║███████║ ╚████╔╝ ███████╗
 ╚═══██╗    ██║  ██║██╔══██║  ╚██╔╝  ╚════██║
██████╔╝    ██████╔╝██║  ██║   ██║   ███████║
╚═════╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝
```
                                             



This is the 3days application by [Isashi Mitsui](https://github.com/Isashi/).


### Requirements

### Gems
* [Devise](https://github.com/plataformatec/devise) for authentication. ✔
*	[OmniAuth Facebook](https://github.com/mkdynamic/omniauth-facebook) for login with Facebook account. ✔
* [Figaro](https://github.com/laserlemon/figaro) for env variables. ✔
* [will_paginate](https://github.com/mislav/will_paginate) for pagination in index pages. ✔
* [Puma](https://github.com/puma/puma) webserver. ✔ 
* [Better Errors](https://github.com/charliesome/better_errors) for debugging. ✔
* [Guard](https://github.com/guard/guard) to run tests continuously. ✔
* [Bootstrap 4](http://materializecss.com) as the CSS Framework. ✔

### Specifications
* Full test coverage with MiniTest.
* Uses [Sendgrid](https://devcenter.heroku.com/articles/sendgrid) for sending emails (password recovery). ✔
* Deployed on Heroku. ✔

### Features
* Users can create Places
* Users can create Cities
* Users can comment on Posts

### Models ✔
```ruby
All ✔
	*_id ✔
	created_at ✔
	updated_at ✔

User: ✔
	username: string ✔
	password: string ✔
	email:    string ✔
      
Place: ✔
	user_id:     references ✔ 
	title:       string ✔
	description: text ✔
	lat: 				 decimal ✔
	long: 		   decimal ✔

Comment: ✔
	user_id:  references ✔
	place_id: references ✔
	body:  text ✔
 
Picture: ✔
	place_id:           references ✔
	image_file_name:    string ✔
	image_content_type: string ✔
	image_file_size:    integer ✔
	iamge_updated_at:   datetime ✔

City: 
	user_id:     references
	name:        string
	description: text


```


### Associations ✔

```ruby
User 
	has_many :places
	has_many :comments, dependent: :destroy
	has_many :cities
    
Place 
	belongs_to :user
	has_many   :comments

City
	belongs_to :user
	has_many   :places
    
Comment
	belongs_to :place
	belongs_to :user

```
    
### Controllers
```ruby
StaticPages
	about:
	contact:
	help: 
	home: 

User ✔
	index:   Show the list of all users ✔
	show:    Show the user's profile page ✔
	update:  Update an existing user ✔
	destroy: Delete a user ✔

Place
	create:  Create a new place
	destroy: Delete an existing place
	update:  Update an existing place

Comment
	create:  Create a new comment
	destroy: Delete an existing comment

```

## License

All source code in the threedays app is available jointly under the MIT License and the Beerware License. See
[LICENSE.md](LICENSE.md) for details.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```
