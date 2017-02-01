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
WORDS_PER_SEC = 250

# Load all questions from the yaml file
all_questions = YAML.load(File.read('data/civics_questions_ca.yaml'))

# Go through questions until you got all questions right
def run_test(questions = Array)
  questions.shuffle.each do |item|
    system('clear')
    item.each do |question, answer|
      puts("[#{questions.size} left] #{question}")
      system("say question, '#{question}' -r #{WORDS_PER_SEC}")
      puts("Press any key to hear the answer")
      # Pause until any character is pressed
      loop do
        system("stty raw -echo")
        STDIN.getc
        system("stty -raw echo")
        break
      end
      system("say '#{answer.join(', or ')}' -r #{WORDS_PER_SEC}")
      print("Did you answer correctly? [y/n] or ctrl+c to exit ")
      $stdout.flush
      loop do
        system("stty raw -echo")
        c = STDIN.getc
        system("stty -raw echo")
        if c.downcase == 'y'
          questions.delete(item)
        end
        break
      end
      puts
    end
  end
  run_test(questions) if questions.size > 0
end

run_test(all_questions)
