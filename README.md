# Old World of Darkness Helper API

An API of helper tools for people storytelling old world of darkness games. 

## Why?
I build tools for my personal oWoD games, but they're spread out across a bunch of programs written in different languages. This aims to centralize common fuctionality like dice rolling and generating disposable henchmen.

## Installation

With ruby installed you only need to run bundler from the root directory.

```bash
bundle install
```

## Usage

To start the server pass `server.rb` to ruby. This will start the server on port 4567.

```bash
ruby server.rb
```

Make a GET request to see if the server is running.

```bash
curl http://localhost:4567
```

If you get a greeting back, the server is up and running.

### Roll the dice

To use the dice roller make a GET request with a query parameter that tells the server how many dice to roll and what the difficulty of the roll is.

```bash
curl "http://localhost:4567/api/v1/roll?num_dice=5&difficulty=7"
```

You will get back a JSON object with an array of face values, how many total successes were achieved, and the overall outcome of the roll.

```json
{
	"difficulty":7,
	"num_dice":5,
	"faces":[1,3,8,10,9],
	"rolled_successes":3,
	"rolled_ones":1,
	"total_successes":2,
	"outcome":"success"
}
```

[See the roll reference in the wiki](https://github.com/dw-jet/wod-storyteller-api/wiki/Roll-Reference) for more in-depth documentation.

## Contributing
Minor pull requests are welcome. Major changes will not be considered until all of the core features are finished.

## License
[MIT](https://choosealicense.com/licenses/mit/)