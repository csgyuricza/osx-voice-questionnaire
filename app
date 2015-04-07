#!/usr/bin/env ruby
#
# === Summary
#
# This program takes a database of questions (in YAML format) and itereates
# randomly throught them reading them out with the OSX 'say' command. Press
# enter to hear the answer, then enter again if you got the answer right or
# any other character + enter if you want the question asked again
#

require 'yaml'

# Speaking speed
WORDS_PER_SEC = 300

# Load all questions from the yaml file
all_questions = YAML.load(File.read('data/civics_questions_ca.yaml'))

# Go through questions until you got all questions right
def run_test(questions = Array)
  questions.shuffle.each do |item|
    puts("#{questions.size} left")
    item.each do |question, answer|
      system("say question, '#{question}' -r #{WORDS_PER_SEC}")
      puts('Send ENTER to hear answer')
      gets.chomp
      system("say '#{answer.join(', or ')}' -r #{WORDS_PER_SEC}")
      puts('Send ENTER to mark it as correct, any other character for incorrect')
    end
    result = gets.chomp
    questions.delete(item) if result.empty?
  end
  run_test(questions) if questions.size > 0
end

run_test(all_questions)