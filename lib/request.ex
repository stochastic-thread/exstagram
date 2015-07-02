defmodule Instagram.Request do
  use HTTPoison.Base

  @url "https://api.instagram.com/v1"
  def process_url(url) do
    case String.downcase(url) do
      <<"http://"::utf8, _::binary>> -> url
      <<"https://"::utf8, _::binary>> -> url
      _ -> @url <> url
    end
  end
end