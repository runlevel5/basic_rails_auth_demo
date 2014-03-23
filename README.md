# Rails Basic Auth demo

Devise or any Warden-based solutions are widely-used but
unattractive for its complexity.

I am going to show you how to implement a very basic auth
for Rails with BCrypt.

Please be noted that my code does not contain any ActiveRecord
callbacks and I also heavily use DCI Service Object pattern.

## Setup

1. Bootstrap DB

```ruby
rake db:create db:migrate
```

2. Create new user under `rails console`

```ruby
UserCreation.create(email: 'your_email', password: 'pass', password_confirmation: 'pass')
```

3. Run server `rails server`

4. You can test the login

## Testing

```ruby
RAILS_ENV=tes rake db:schema:load
bundle exec rake spec
```

## Author

Trung Lê <trung_dot_le_at_ruby_dash_journal_dot_com>

## License

MIT
