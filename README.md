# Odinbook

A Ruby on Rails social media app with the core functionality of Facebook.

View a live version [on Heroku](https://peaceful-gorge-29362.herokuapp.com/).
- You may log in by entering the username `user` and password `password`
- **Note:** Due to being on Heroku's free plan, initial load time may be longer than expected

![alt text](app_demo.gif?raw=true "video demo of Odinbook")

This is the [final assignment ](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project) for the Rails section of [The Odin Project](https://www.theodinproject.com).

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
- Beautifully designed with Bootstrap
- Tested with RSpec and Capybara (96% code coverage)

## How to Use
#### Live Version
[Click here to view a live version on Heroku.](https://peaceful-gorge-29362.herokuapp.com/)
- **Note:** Due to being on Heroku's free plan, initial load time may be longer than expected

#### Local Version
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

## Possible Improvements:
- Allow users to change their username
- Use Turbo Frames for other parts of the app to emulate a single-page application and improve user experience
- Allow posts to be edited
- Allow comments to be deleted
- Allow comments to be liked via polymorphic associations
- Require confirmation before letting a user remove a friend
- Responsive design
- Add `Liked Posts` section on user profiles
- Add more validations

## Reflections
I knew this would be a very fun project right from the start, and it definitely was. Initially, I made a lot of rapid progress. A lot of the core functionality was implemented in less than a week. However, implementation of some non-core features, the design and countless tweaks and adjustments to different aspects of the app ended up taking a considerable amount of time.

The two most difficult implementations:
- `Friendships`
- Figuring out how to use Turbo Frames for liking/unliking posts. The goal was to give this part of the app a single-page application feel. If a user clicks Like, update the likes count and swap the Like button with an Unlike button, and vice versa. After lots of research, following multiple guides, referencing docs, and guidance from the helpful folks in The Odin Project's Discord server, I was able to achieve the desired result

The layout/design of the app took much longer than I expected, mainly because of the countless tweaks and improvements that were continually made, and because it was my first time using a CSS framework (Bootstrap).

Overall, I gained an incredible amount of knowledge and experience, and this journey skyrocketed the confidence that I have in my ability to build beautiful and complex Ruby on Rails apps.

## Acknowledgements
I'd like to thank the generous people in the `#rails-help` channel of The Odin Project's Discord that took the time to answer any questions I had and guided me through difficulties. Specifically, I wish to thank [Josh](https://github.com/JoshDevHub) and [Simmon](https://github.com/crespire) for helping me resolve two perplexing errors in the app's asset pipeline and comment modals.
