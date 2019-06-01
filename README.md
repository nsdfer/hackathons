# Tony

---

## Prerequisites

1. [brew](http://brew.sh)
1. [mongodb](https://www.mongodb.com/download-center/v2/community)

### Ruby on Rails
1. [ruby](https://www.ruby-lang.org/en/documentation/installation/)

  ```sh
  brew install ruby
  ```

1. [rbenv](https://github.com/sstephenson/rbenv#installation)

  ```sh
  brew install rbenv
  ```

1. [bundler](https://bundler.io/)

  ```sh
  gem install bundler
  ```

1. Create `.env` file for local development environment variables. Example:

  ```sh
  # Required
  MONGO_URL=mongodb://localhost:27017/tony
  ```
---

## Setup
1. `rbenv install $(cat .ruby-version) && rbenv global $(cat .ruby-version)`
1. `bundle`

---

## Workflow
1. Start MongoDB
  ```sh
  mongod
  ```

1. Start backend server
  ```sh
  bin/rails server
  ```
## Deployment
TBD
