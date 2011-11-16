# Lorem Ipsum Tracker

Add stories in bulk to Pivotal Tracker using boilerplate text from the
brilliant [Hipster Lorem Ipsum](http://hipsteripsum.me/) generator and
random-but-realistic labels, story states, etc.

This does not reliably result in STORY_COUNT stories ending up in the
tracker. Perhaps some kind of rate-based throttling on the Pivotal
Tracker REST endpoint. 

I don't have the inclination to dig around and discover why, but if you
do, please by all means send me a pull request.

to use:

  export API_TOKEN=<your API token>
  export PROJECT_ID=<your project id>
  export STORY_COUNT=<how many stories to add>

  ruby ./lorem-tracker.rb
