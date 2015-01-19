# FeedMe

This project is a clone of [feedly](www.feedly.com), adding a number of social features.


## Features

### MVP Features

* Users can sign up.
* Users can sign in.
* Users can sign out.
* Users can subscribe to feeds.
* Users can unsubscribe from feeds.
* Users can display the subscribed feeds individually.
* Users can display an aggregate feed comprising all their subscribed feeds.
* Feeds will update when displayed.
* Users can place feeds in categories.
* Users can remove feeds from categories.
* Users can display an aggregate feed comprising all the feeds in a given category.
* Users can view each item in a feed.
* Users can mark an item as read.
* Users can unmark an item as read.
* Users can view feeds including read items.
* Users can mark an item as archived.
* Users can unmark and item as archived.
* Users can view feeds including archived items.
* Feeds can be updated to not display items that have been read.
* Users can refresh feeds
* Email verification of user accounts.
* Password reset emails
* Profile allows updating password.

### Important Features
* Publishes a user's recently read articles as a new feed.
* Find Username features
* Allows a user to set their recently read feed to publc or private.
* Generates an aggregate feed of a user's recently read articles.
* User profile with image and profile-description
* Users can comment on other users profiles
* Users can comment on articles.
* Users can follow other users.
* Users can view comments made by users they follow.
* Portal that suggests popular feeds based on categories.
* Users can assign different colors to feeds, changing the background of items that appear in aggregate feeds.
* Allows logins from multiple sources.
* Responsive design

### Further Features
* Automatically archive old items in a feed.
* Create keyboard interface for going through feeds.
* Keyboard commands:
  * ? - display keyboard shortcuts
  * n - next article
  * p - previous article
  * shift-n - next feed
  * shift-p - previous feed
  * \#(number) select article by number
  * v - view article inline/close article view
  * g - guilt read an article
  * o - open article in new tab
  * m - mark article as read
  * shift-m - mark all as read
  * a - archive article
  * shift-a - mark all as archived
  * r - refresh feed
  * ta - go to all aggregation
  * tg - open feed search bar
* Tutorial that demonstrates how to use.
* Help page that documents where to find features.
* About pages that lists information about the app.
* Different styles of display:  
  * Title
  * Magazine
  * Cards
* Users can see graphs of:
  * Most viewed feeds.
  * Articles archived and read in a feed
  * Overall articles read in different time-frames
* Users can delete accounts

### Group Features
* Users can form groups.
* Users can join groups.
* Users can leave groups.
* Users can comment on group articles.
* Users can be group administrators.
* Group administrators can set an aggregate feed for the group.
* Group administrators can see which articles members have read.
* Group members can see how many reads articles have.

### Pie-In-The-Sky Features
* Browser extensions to easily add  feeds to an account.
* Users can import feeds in OPML format.


## Models

### MVP
* User
* UserFeed
* Feed
* Article
* UserArticle
* Category
* FeedCategory

### Important
* Comment
* ?Article Archive?

### Group
* Group
* GroupMembership
* GroupFeed
* GroupArticle

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

### UserFollows

Table name: user_follows

|Column         | Type     |  Properties|
|---------------|----------|------------|
|id             |:integer  | not null, primary key|
|followed_id    |:integer  | not null   |
|following_id   |:integer  | not null   |
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
|curator_id     |:integer  |
|created_at     |:datetime |         |
|updated_at     |:datetime |         ||

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

### FeedEntry

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|entry_id        |:integer  | not null   |
|feed_id         |:integer  | not null   ||

### UserReadEntries

Table name: user_read_entries

|Column          | Type     |  Properties|
|----------------|----------|------------|
|id              |:integer  | not null, primary key|
|user_id         |:integer  | not null, foreign key|
|entry_id      |:integer  | not null, foreign key|
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
