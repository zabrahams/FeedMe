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
