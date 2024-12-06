defmodule Fcmex.Request do
  @moduledoc """
  Handles making the messaging request to Firebase
  """

  use Retry
  alias Fcmex.{Util, Config, Payload}

  def perform(to, opts) do
    with payload <- Payload.create(to, opts),
         result <- post(payload, opts) do
      Util.parse_result(result)
    end
  end

  defp post(%Payload{} = payload, opts) do
    endpoint = Keyword.get(opts, :endpoint, get_default_fcm_endpoint())
    payload = payload |> build_payload() |> Config.json_library().encode!()

    retry with: exponential_backoff() |> randomize |> expiry(10_000) do
      HTTPoison.post(
        endpoint,
        payload,
        Config.get_headers(),
        Config.httpoison_options()
      )
    after
      result -> result
    else
      error -> error
    end
  end

  defp get_default_fcm_endpoint() do
    project_id = Config.get_project_id()
    url = "https://fcm.googleapis.com/v1/projects/#{project_id}/messages:send"
  end

  defp build_payload(payload) do
    %{
      "message" => payload
    }
  end
end
