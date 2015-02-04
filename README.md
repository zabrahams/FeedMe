# FeedMe

## Description

FeedMe is a social news reader that lets users share and comment on what they are reading.

FeedMe is live at [www.feed--me.com](http://www.feed--me.com)

FeedMe users can add feeds, organize feeds into custom categories. They can view the aggregate entries from all their feeds or from a particular category. FeedMe also helps users see the articles they have read recently, and share that reading list with the world.

FeedMe publishes an RSS feed for every user containing their recently read entries, but it also makes these curated feeds easily accessible to other users. By following other users, a watcher automatically gets the curators feed added to her overall list of feeds.  

Users can comment on each other's profiles or on a particular entry.  These comments are visible to all other users, allowing conversation to spring up among diverse users over interesting articles.

## Technical Features

* Single page Backbone.js Application.
* Consumes a Rails JSON API.
* Custom built authentication uses BCrypt for encrypting passwords and security question answers.
* Leverages sendmail for activation and password reset emails.
* Uses feedjira to fetch and parse feeds.
* Uses Redis and Resque to update feeds in background jobs.
* Uses unicorn to run worker and web processes on a single heroku web dyno.
* Implements a keyboard interface and flash message system using an event aggregator that allows for communication across Backbone views.
* Extends Backbone.View with listView and compositeView classes to create nested Backbone views.
* Polymorphic comments model allows comments to be placed on users or on entries.
* Stores profiles pictures on Amazon S3. Uses Paperclip for image uploads to S3.
* Backend test suite uses RSpec, shoulda-matchers, factory girl and faker.
* Uses Kaminari pagination for an infinite scroll on pages that list entries.  Not only is it a nice interface, it also seriously reduces load time by limiting the number of entries downloaded in a request.
* JQuery UI is used for the drag and drop editing of categories and the indefinite progress bar that displays during AJAX requests.


## Models

* Category
* CategoryFeed
* Comment
* Entry
* FeedEntry
* Feed
* SecurityQuestionAnswer
* SecurityQuestion
* UserFeed
* UserFollow
* UserReadEntries
* User


## Schema

### User

Table name: users

|Column         | Type     |  Properties|
|---------------|----------|------------|
|id              |:integer   | not null, primary key|
|username        |:string    | not null|
|email           |:string    | not null|
|password_digest |:string    | not null|
|session_token   |:string    | not null|
|activated       |:boolean   | not null|
|activation_token|:string    | not null|
|reset_token     |:string    |         |
|description     |:text      |         |
|fname           |:string    |         |
|lname           |:string    |         |
|image           |:attachment|         |
|created_at      |:datetime  |         |
|updated_at      |:datetime  |         ||

### UserFollow

Table name: user_follows

|Column         | Type     |  Properties|
|---------------|----------|------------|
|id             |:integer  | not null, primary key|
|watcher_id     |:integer  | not null, foreign key|
|curator_id     |:integer  | not null, foreign key|
|created_at     |:datetime | not null   |
|updated_at     |:datetime | not null   ||

### Feed

Table name: feeds

|Column         | Type     |  Properties|
|---------------|----------|------------|
|id             |:integer  | not null, primary key|
|name           |:string   | not null |
|url            |:string   | not null |
|curated        |:boolean  | default false|
|curator_id     |:integer  | foreign_key  |
|created_at     |:datetime |         |
|updated_at     |:datetime |         ||

### FeedEntry

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|entry_id        |:integer  | not null, foreign key|
|feed_id         |:integer  | not null, foreign key|
|created_at      |:datetime |         |
|updated_at      |:datetime |         ||


### UserFeed

Table name: user_feeds

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|user_id         |:integer  | not null, foreign key|
|feed_id         |:integer  | not null, foreign key|
|background_color|:string   |            |
|created_at      |:datetime |            |
|updated_at      |:datetime |            ||

### Entry

Table name: entries

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|guid            |:text     | not null   |
|title           |:string   |            |
|link            |:string   |            |
|published_at    |:datetime | not null   |
|feed_id         |:integer  | not null, foreign key|
|json            |:text     | not null   |
|created_at      |:datetime |            |
|updated_at      |:datetime |            ||

### UserReadEntry

Table name: user_read_entries

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|user_id         |:integer  | not null, foreign key|
|entry_id        |:integer  | not null, foreign key|
|created_at      |:datetime |            |
|updated_at      |:datetime |            ||


### Category

Table name: categories

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|name            |:string   | not null |
|user_id         |:integer  | not null, foreign key|
|created_at      |:datetime |            |
|updated_at      |:datetime |            ||

### CategoryFeed

Table name: category_feeds

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|feed_id         |:integer  | not null, foreign key|
|category_id     |:integer  | not null, foreign key|
|created_at      |:datetime |            |
|updated_at      |:datetime |            ||

### Comment

Table name: comments

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|body            |:text     | not null   |
|author_id       |:integer  | not null, foreign key|
|commentable_id  |:integer  | not null, foreign key|
|commentable_type|:string   | not null   |
|created_at      |:datetime |            |
|updated_at      |:datetime |            ||

### SecurityQuestion

Table name: security_questions

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|content         |:text     | not null   |
|created_at      |:datetime |            |
|updated_at      |:datetime |            ||

### SecurityQuestionAnswer

Table name: security_question_answers

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|answer_digest   |:string   | not null   |
|question_id     |:integer  | not null, foreign key|
|user_id         |:integer  | not null, foreign key|
|created_at      |:datetime |            |
|updated_at      |:datetime |            ||
