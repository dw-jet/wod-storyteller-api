require "sinatra"
require "sinatra/namespace"
require "thin"

def roll_dice(numberDice, difficulty)
  all_rolls = []
  numberDice.times do 
    all_rolls.push(rand(10)+1)
  end
  return generate_results(all_rolls, difficulty)
end

def generate_outcome(total_successes)
  if total_successes > 0
    outcome = "success"
  elsif total_successes < 0
    outcome = "botch"
  else
    outcome = "failure"
  end
  return outcome
end

def generate_results(rolls, difficulty)
  ones = rolls.filter { |roll| roll == 1 }
  successes = rolls.filter { |roll| roll >= difficulty }
  total_successes = calculate_successes(successes, ones)
  outcome = generate_outcome(total_successes)

  return {
    difficulty: difficulty,
    num_dice: rolls.count,
    faces: rolls,
    rolled_successes: successes.size,
    rolled_ones: ones.size,
    total_successes: total_successes,
    outcome: outcome
  }
end

def calculate_successes(successes, ones)
  successes.count - ones.count
end

get '/' do
  'Welcome to my Old World of Darkness Dice Roller'  
end

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  helpers do
    def base_url
      @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
    end

    def json_params
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message:'Invalid JSON' }.to_json
      end
    end
  end

  get '/roll' do
    num_dice_int = params['numDice'].to_i
    halt(400, {message:'num_of_dice must be a positive integer'}.to_json) unless num_dice_int.integer? && num_dice_int > 0    
    params.has_key?('difficulty') && params['difficulty'] ? difficulty = params['difficulty'].to_i : difficulty = 6
    halt(400, {message: 'There is a problem with the difficulty you passed in. Make sure it is an integer'}.to_json) unless difficulty > 1
    roll_dice(num_dice_int, difficulty).to_json
  end
end