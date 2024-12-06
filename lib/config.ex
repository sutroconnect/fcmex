defmodule Fcmex.Config do
  @moduledoc ~S"
    A configuration for FCM
  "

  def get_headers do
    [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{Fcmex.TokenExtractor.get_token()}"}
    ]
  end

  def get_project_id() do
    Application.get_env(:fcmex, :project_id)
    || retrieve_on_run_time("FCM_PROJECT_ID")
    || raise "FCM project_id key is not found on your environment variables"
  end

  def retrieve_on_run_time(key) do
    System.get_env(key)
  end

  def httpoison_options() do
    Application.get_env(:fcmex, :httpoison_options, [])
  end

  def json_library do
    Application.get_env(:fcmex, :json_library, Poison)
  end
end
