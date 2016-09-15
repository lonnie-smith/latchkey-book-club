# Latchkey Book Club Website: http://latchkeybook.club

## About
This is a small single-page web app I wrote for my book club. We use it to post meeting and book information and to keep track of cultural recommendations made by club members.

After each meeting, we update the site by entering new meeting and recommendation data in a [Google spreadsheet](https://docs.google.com/spreadsheets/d/1JBruoPcv0lNNLqP8MtLgtLPYubHREutb1xZTmR0WMdE/edit#gid=0).

When the site is loaded, it pulls down this data, and pulls book information & thumbnail photos from the Google Books API.

The woodcut on the site's front page is the frontispiece from a 1710 edition of Jonathan Swift’s _Battle of the Books_, in which books come alive and fight an epic battle between Classical and modern texts. Fonts are [Bebas Neue](https://www.fontsquirrel.com/fonts/bebas-neue) and [Old Standard TT](https://www.fontsquirrel.com/fonts/old-standard-tt), which I thought were reminiscient of early 20th century print culture; HT [Typewolf](https://www.typewolf.com/) for the font pairing. I picked icons for maximum whimsy from [The Noun Project](https://thenounproject.com/).

## Tour

I try to follow John Papa’s magesterial [Angular Style Guide](https://github.com/johnpapa/angular-styleguide/blob/master/a1/README.md) as much as possible.

I use [CoffeeScript](http://coffeescript.org) and [SASS](http://sass-lang.com) in my projects wherever possible, partly because I just like whitespace delimited languages, but mostly because I find SASS variables and CoffeeScript’s looping and object syntax so useful that they’re worth the inconvenience.

### How the code is organized.
* All code for the front-end app goes in `app/`. External dependencies, build scripts, and other fol-de-rol goes in the top-level directory.
* `./app/index.html` is the entry point. Application-wide configuration and module setup are in `./app/app-config.coffee` and `./app/app-module.coffee`.
* Stylesheets and other elements (such as the nav bar) that are used across the whole site are in `app/layout/`
* The code for the Meeting and Recommendations pages go in separate folders: `./app/meetings/` and `./app/recos/`.
* Compiling SASS and CoffeeScript files generates a lot of clutter which I don’t like in my main source folders, so there’s a paralell file structure created under `./app/_compiled` to house compiled files.

### Setting up a development environment

* Install [Node](https://nodejs.org/) and [Ruby]([https://www.ruby-lang.org/) on your machine if you don’t have them already.
* Install [Grunt](http://gruntjs.com/): `sudo npm install -g grunt-cli`.
* Run `npm install` and `bower install` to install dependendencies.
* Compile the source: `grunt build`.
* Start a development server: `grunt connect`—then open the page at [http://localhost:8080/app/](http://localhost:8080/app/)
* Automatically recompile & reload code changes when source files are edited: `grunt watch`


