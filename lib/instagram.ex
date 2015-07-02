defmodule Instagram do
  use OAuth2.Strategy

  # Public API

  def new do
    HTTPoison.start
    OAuth2.new([
      strategy: __MODULE__,
      client_id: System.get_env("CLIENT_ID"),
      client_secret: System.get_env("CLIENT_SECRET"),
      redirect_uri: System.get_env("CALLBACK_URL"),
      site: "https://api.instagram.com",
      authorize_url: "https://api.instagram.com/oauth/authorize/",
      token_url: "https://api.instagram.com/oauth/access_token"
    ])
  end

  @url "https://api.instagram.com/v1"
  def process_url(url) do
    case String.downcase(url) do
      <<"http://"::utf8, _::binary>> -> url
      <<"https://"::utf8, _::binary>> -> url
      _ -> @url <> url
    end
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

  def user_recent_media(access_token) do
  	url = "https://api.instagram.com/v1/users/self/media/recent?access_token="
  	req = url <> access_token
    case HTTPoison.get(req) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json_body = Poison.decode! body
        # json_body["data"] |> Enum.map fn(x) -> x["images"]["standard_resolution"]["url"] end
        json_body["data"] |> Enum.map fn(x) -> x end
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  def start do
    auth_url = Instagram.authorize_url!
    response = HTTPoison.get! auth_url
    response_as_map = response.headers |> Enum.into(%{})
    response_as_map["Location"]
  end

  def get_token(code_dict) do
    Instagram.get_token! code_dict
  end
end