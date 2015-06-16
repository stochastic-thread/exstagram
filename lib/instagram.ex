defmodule Instagram do
  use OAuth2.Strategy

  # Public API

  def new do
  	HTTPoison.start
    OAuth2.new([
      strategy: __MODULE__,
      client_id: "0ea85f47337f4b1d809d0739f71d60b3",
      client_secret: "5bd83bf6d0d247e685811e1232095a0a",
      redirect_uri: "https://exstagram-example.herokuapp.com/auth/callback",
      site: "https://api.instagram.com",
      authorize_url: "https://api.instagram.com/oauth/authorize/",
      token_url: "https://api.instagram.com/oauth/access_token"
    ])
  end

  def authorize_url!(params \\ []) do
    new()
    |> put_param(:scope, "basic")
    |> OAuth2.Client.authorize_url!(params)
  end

  def get_token!(params \\ [], headers \\ []) do
    OAuth2.Client.get_token!(new(), params, headers)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end

  def user_recent_media(token) do
  	access_token = token.access_token
  	url = "https://api.instagram.com/v1/users/self/media/recent?access_token="
  	req = url <> access_token
  	OAuth2.AccessToken.get!(token,req)
  end
  
  def start do
	  auth_url = Instagram.authorize_url!
	  response = HTTPoison.get! auth_url
	  response_as_map = response.headers |> Enum.into(%{})
	  response_as_map["Location"]
  end

  def get_token(code_dict) do
	  # code needs to be a dict with the code that you got back from the Instagram.start url
	  # %{:code => "1e4b06735a0240ef83174cbd690a278c"}
	  token = Instagram.get_token! code_dict
	  token
  end
end