defmodule ChatbotWeb.Router do
  use ChatbotWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ChatbotWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :chatbot do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
  end

  live_session :chatbot, root_layout: {ChatbotWeb.Layouts, :chatbot_root}, layout: {ChatbotWeb.Layouts, :chatbot} do
    scope "/", ChatbotWeb do
      pipe_through [:chatbot]
      live "/chatbot", ChatbotLiveView
    end
  end

  scope "/", ChatbotWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

end
