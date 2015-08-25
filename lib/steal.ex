defmodule KV do
  def start_link do
    Task.start_link(fn -> loop([]) end)
  end

  defp loop(list_perm) do
    receive do
      {:add, url} ->
        resp = HTTPoison.get! url
        json_body = Poison.decode! resp.body
        list = json_body["data"] |> Enum.map fn(x) -> x["images"]["standard_resolution"]["url"] end
        list_perm
        send self(), json_body["paginate"]
        IO.puts list_perm
        loop(list_perm ++ list)
    end
  end
end