# Odinbook

A Ruby on Rails social media app with the core functionality of Facebook.

View a live version [on Heroku](https://peaceful-gorge-29362.herokuapp.com/). You may log in by entering the username `user` and password `password`. (**Note:** Due to being on Heroku's free plan, initial load time may be longer than expected.)

![alt text](login_page.png?raw=true "screenshot of Odinbook home page")

## Features
- Log in via Facebook (handled via OmniAuth gem) or create an account (via Devise gem)
- Posts
  - Create posts
  - Comment on posts
  - Like posts
- Friend requests: send, cancel, accept, or decline friend requests
- Users can have a profile photo (must be uploaded separately via Gravatar)
- View profile page of any user, which: 
  - Shows posts and friends of that user
  - Shows personal info (name, age, gender and location) if the user has added that info
- View notifications of received friend requests
- Send welcome email to new users when they sign up (only available in local version)
- Turbo Frames used for liking/unliking posts to improve user experience
- Tested with RSpec and Capybara (96% code coverage)

## How to Use
### Live Version
[Click here to view a live version on Heroku.](https://peaceful-gorge-29362.herokuapp.com/) (**Note:** Due to being on Heroku's free plan, initial load time may be longer than expected.)

### Local Version
To run locally, you must have the following prerequisites:
```
Ruby >= 3.1.2
Rails >= 7.0.3
Bundler >= 2.3.6
PostgreSQL >= 14.3
```
Then, clone this repo, `cd` into the project's root directory and run:
```
bundle install
bin/rails server
```
Finally, visit http://localhost:3000/ to view the application.

## Known Bugs
- No error message is displayed by Devise if wrong password is entered while logging in (may be due to an incompatibility with Rails 7 and Devise)
- Profile photos are only displayed on a user's profile page
- Refactor `random_strangers` method in `app/models/user.rb`

## Possible Improvements:
- Allow users to change their username
- Use Turbo Frames for other parts of the app to emulate a single-page application and improve user experience
- Allow posts to be edited/deleted
- Allow comments to be deleted
- Allow comments to be liked via polymorphic associations
- Require confirmation before letting a user remove a friend
- Improve layout of comments (very lengthy comments are displayed in an undesired manner)

## Reflections
