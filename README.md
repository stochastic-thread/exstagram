
# elixstagram

Instagram v1 API wrapper written in Elixir.

Please note, this is very much a work in progress. 
Feel free to contribute using pull requests.

## Example usage

I made this simple phoenix app to show how to use exstagram!

See it in action on Heroku:
https://exstagram-example.herokuapp.com

Here is the code for the above Heroku app:
https://github.com/arthurcolle/exstagram_example

To run it yourself, please run the following commands:
* `git clone https://github.com/arthurcolle/exstagram_example`
* `cd exstagram_example`
* `mix deps.get`
* `npm install` (may not be needed, but if you see any node-esque "throw err;" messages, this is why)

Before you can run it yourself, you'll have to configure three environment variables:
They are `CLIENT_ID`, `CLIENT_SECRET`, and `CALLBACK_URL` (see `exstagram/lib/instagram.ex` for usage)
Finally, run:
* `mix pheonix.server`


## Contributors
* Clone repo, i.e. `git clone https://github.com/arthurcolle/exstagram`
* Run `mix deps.get`
* To give it a try, run `iex -S mix`

Put this in your `mix.exs` deps section:
```
     {:instagram, "0.0.2", [github: "arthurcolle/exstagram"]}
```

See other cool Elixir repos at [awesome-elixir](https://github.com/h4cc/awesome-elixir)

Not on hex.pm yet, but coming soon!
