# Lorem Ipsum Tracker

Add stories in bulk to Pivotal Tracker using boilerplate text from the
brilliant [Hipster Lorem Ipsum](http://hipsteripsum.me/) generator and
random-but-realistic labels, story states, etc.

There is a sample on a public tracker project here: [Lorem Tracker
Example](https://www.pivotaltracker.com/projects/415649)

## Caveats

This does not reliably result in STORY_COUNT stories ending up in the
tracker. Perhaps some kind of rate-based throttling on the Pivotal
Tracker REST endpoint. 

I don't have the inclination to dig around and discover why, but if you
do, please by all means send me a pull request.

Please do not annihilate your production tracker for work! Be careful.
Sorrow awaits the unwary.

## Howto

to use:

```
bundle install

export API_TOKEN=<your API token>
export PROJECT_ID=<your project id>
export STORY_COUNT=<how many stories to add>

ruby ./lorem-tracker.rb
```

## Addendum

This was written versus Ruby 1.9.3-preview1. YMMV.
