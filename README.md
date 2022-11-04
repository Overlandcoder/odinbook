# Odinbook

A Ruby on Rails social media app with the core functionality of Facebook.

View a live version [on Heroku](https://peaceful-gorge-29362.herokuapp.com/).
> **Note:** Due to being on Heroku's free plan, initial load time may be longer than expected.

![alt text](homepage.png?raw=true "screenshot of Odinbook home page")

## Features
- Log in via Facebook (handled via OmniAuth gem) or create an account (via Devise gem)
- Posts
  - Create posts
  - Comment on posts
  - Like posts
- Friend requests: send, cancel, accept, or decline friend requests
- Users can have a profile photo (must be uploaded separately via Gravatar)
- User profile pages: 
  - Show posts and friends of a user
  - Show personal info (name, age, gender and location) if a user has added that info


## Possible Improvements:
- Allow users to change their username
