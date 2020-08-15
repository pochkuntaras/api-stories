# API Stories

The API for simple application for saving your stories written on [Ruby on Rails](https://rubyonrails.org/).

## Installation

It's preferable that you'll use [RVM](https://rvm.io/) for managing gems and ruby versions.

Go to project directory and install appropriate version of ruby and create gemset for the project as described in **.ruby-version** and **.ruby-gemset** files.

### Install gems by running:

```bash
bundle install
```

Copy **master.key.example** as **master.key** and configure them.

### Editing ENV

For edit **ENV** variables you should run:
 
```bash
EDITOR="vim" rails credentials:edit
```

Create database:

```bash
rails db:create db:schema:load
```

Start your server:

```bash
rails server
```
