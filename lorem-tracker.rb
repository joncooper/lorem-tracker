require 'bundler'
Bundler.require

IPSUM_FILE = 'hipster-ipsum.txt'
IPSUM_TEXT = File.readlines(IPSUM_FILE)

API_TOKEN = ENV['API_TOKEN']
PROJECT_ID = ENV['PROJECT_ID'].to_i
STORY_COUNT = ENV['STORY_COUNT'].to_i

unless (API_TOKEN && PROJECT_ID)
  puts "Please pass API_TOKEN, PROJECT_ID, and STORY_COUNT."
  exit
end

def ipsum_sentence
  sentences = ipsum_paragraph.strip.split('.')
  sentences[rand(sentences.length - 1)] + "."
end

def ipsum_paragraph
  IPSUM_TEXT[rand(IPSUM_TEXT.length - 1)]
end

def random_story_type
  seed = rand(10)
  case
  when seed >= 2
    'feature'
  when seed == 1
    'chore'
  when seed == 0
    'bug'
  end
end

def random_current_state
  seed = rand(10)
  case
  when seed >= 4
    'unstarted'
  when [3,4].include?(seed)
    'delivered'
  when seed == 2
    'accepted'
  when seed == 1
    'started'
  when seed == 0
    'unscheduled'
  end
end

def random_set_of_labels(story_type)
  return if ['bug', 'chore'].include?(story_type)

  seed = rand(10)
  case
  when seed >= 7
    ['blocked_art', 'blocked_eng', 'blocked_pm'][rand(3)]
  when seed == 1
    ['needs_estimation']
  when seed == 0
    ['needs_elaboration']
  end
end

def random_estimate(story_type, labels)
  return if labels && labels.include?('needs_estimation')
  return if ['bug', 'chore'].include? story_type
  rand(3) + 1
end

def fake_story
  story_type = random_story_type
  labels = random_set_of_labels(story_type)
  {
    :name => ipsum_sentence,
    :story_type => story_type,
    :estimate => random_estimate(story_type, labels),
    :description => ipsum_paragraph,
    :current_state => random_current_state,
    :labels => labels
  }
end

def show_progress
  print '#'
  STDOUT.flush
  sleep(1.0/4.0)
end

PivotalTracker::Client.token = API_TOKEN
@tracker_project = PivotalTracker::Project.find(PROJECT_ID)

puts "Adding #{STORY_COUNT} stories."

STORY_COUNT.times do
  @tracker_project.stories.create(fake_story)
  show_progress
end

puts
puts "done."
