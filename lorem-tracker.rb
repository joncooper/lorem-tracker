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
  when [2,3].include?(seed)
    'delivered'
  when seed == 1
    'started'
  when seed == 0
    'unscheduled'
  end
end

def random_set_of_labels
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

def fake_story
  {
    :name => ipsum_sentence,
    :story_type => random_story_type,
    :description => ipsum_paragraph,
    :current_state => random_current_state,
    :labels => random_set_of_labels
  }
end

PivotalTracker::Client.token = API_TOKEN
@tracker_project = PivotalTracker::Project.find(PROJECT_ID)
STORY_COUNT.times do
  @tracker_project.stories.create(fake_story)
end
