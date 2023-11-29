defmodule ChatbotWeb.ChatbotLiveView do
  use ChatbotWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
    socket
    |> assign(messages: [%{id: :welcome, type: :received, body: "Hi 👋 I am an AI-Powered chatbot, ask me anything!"}])
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full h-full overflow-hidden flex flex-col">
      <%= render_header(assigns) %>
      <%= render_messages(assigns) %>
      <div class="mt-auto">
        <%= render_textfield(assigns) %>
      </div>
    </div>
    """
  end

  defp render_header(assigns) do
    ~H"""
    <div class="flex h-16 grow-0 shrink-0 bg-[#4635b8]">
      <div class="my-auto mx-4 w-full font-bold text-lg text-left text-white">
        Welcome to AI Chatbot
      </div>
    </div>
    """
  end

  defp render_messages(assigns) do
    ~H"""
    <div class="text-sm flex flex-col w-full space-y-4 my-4 grow shrink overflow-scroll">
      <%= for message <- @messages do %>
          <%= case message[:type] do %>
            <% :received -> %>
              <div class="max-w-[80%] w-fit ml-3 p-2 rounded-md bg-gray-100 "><%= message.body %></div>
            <% :composing -> %>
              <div>COMPOSING</div>
            <% :sent -> %>
              <div class="max-w-[80%] ml-auto mr-3 p-2 rounded-md bg-[#D6F4F5]"><%= message.body %></div>
          <% end %>
      <% end %>
    </div>
    """
  end

  defp render_textfield(assigns) do
    ~H"""
    <div x-data={"{value:''}"} id="chat-input" phx-hook="PushEvent" class="mb-2 grow-0 shrink-0">
      <div class="mx-4 mb-4 px-1 flex flex-row justiry-center items-center rounded-md border border-gray-300">
        <div class="grow">
            <textarea x-data="{ shiftPressed: false }"
                      x-model={"value"}
                      rows="1"
                      name={:chat_input}
                      x-on:keydown.shift="shiftPressed = true"
                      x-on:keyup.shift="shiftPressed = false"
                      x-on:keydown.enter.prevent={enter_script()}
                      class="mt-1.5 w-full px-2 text-sm border-transparent focus:border-transparent focus:ring-0 focus:ring-offset-0 resize-none bg-transparent"
                      placeholder={"Type a reply..."}></textarea>
        </div>
        <div class="h-full pl-1 pr-1.5 cursor-pointer" x-on:click={"pushEventHook.pushEventTo($el, 'user_input', {value: value}); value = ''"}>
          <svg class="fill-[#4635b8] w-7 h-7 hover:opacity-70" fill="none" viewBox="0 0 24 24">
            <path fill-rule="evenodd" d="M18.1437 3.63083C16.9737 3.83896 15.3964 4.36262 13.1827 5.10051L8.17141 6.77094C6.39139 7.36428 5.1021 7.79468 4.19146 8.182C3.23939 8.58693 2.90071 8.86919 2.79071 9.0584C2.45191 9.64118 2.45191 10.361 2.79071 10.9437C2.90071 11.1329 3.23939 11.4152 4.19146 11.8201C5.1021 12.2075 6.39139 12.6379 8.17141 13.2312C8.19952 13.2406 8.22727 13.2498 8.25468 13.2589C8.74086 13.4206 9.11881 13.5464 9.44395 13.764C9.75719 13.9737 10.0263 14.2428 10.236 14.5561C10.4536 14.8812 10.5794 15.2592 10.7411 15.7453C10.7502 15.7727 10.7594 15.8005 10.7688 15.8286C11.3621 17.6086 11.7925 18.8979 12.1799 19.8085C12.5848 20.7606 12.867 21.0993 13.0563 21.2093C13.639 21.5481 14.3588 21.5481 14.9416 21.2093C15.1308 21.0993 15.4131 20.7606 15.818 19.8085C16.2053 18.8979 16.6357 17.6086 17.2291 15.8286L18.8995 10.8173C19.6374 8.60363 20.161 7.02627 20.3692 5.85629C20.5783 4.68074 20.4185 4.1814 20.1185 3.88146C19.8186 3.58152 19.3193 3.42171 18.1437 3.63083ZM17.8746 2.11797C19.1768 1.88632 20.3496 1.93941 21.2051 2.79491C22.0606 3.65041 22.1137 4.82322 21.882 6.12542C21.6518 7.41975 21.0903 9.10415 20.3794 11.2367L18.6745 16.3515C18.096 18.0869 17.6465 19.4354 17.232 20.41C16.8322 21.35 16.3882 22.1457 15.7139 22.5377C14.6537 23.1541 13.3442 23.1541 12.284 22.5377C11.6096 22.1457 11.1657 21.35 10.7658 20.41C10.3513 19.4354 9.90184 18.0869 9.32338 16.3515L9.31105 16.3145C9.10838 15.7065 9.04661 15.5416 8.95909 15.4109C8.86114 15.2646 8.73545 15.1389 8.58913 15.0409C8.4584 14.9534 8.29348 14.8916 7.68549 14.689L7.64845 14.6766C5.91306 14.0982 4.56463 13.6487 3.59005 13.2342C2.64996 12.8343 1.85431 12.3904 1.46228 11.716C0.845907 10.6558 0.845908 9.34634 1.46228 8.28611C1.85431 7.61177 2.64996 7.16781 3.59005 6.76797C4.56464 6.35345 5.91309 5.90397 7.64852 5.3255L12.7633 3.62057C14.8959 2.9097 16.5803 2.34822 17.8746 2.11797ZM17.6807 6.32532C17.9791 6.62702 17.9764 7.11348 17.6747 7.41185L13.5771 11.4643C13.2754 11.7627 12.7889 11.76 12.4905 11.4583C12.1921 11.1566 12.1948 10.6701 12.4965 10.3718L16.5942 6.3193C16.8959 6.02092 17.3823 6.02362 17.6807 6.32532Z" clip-rule="evenodd">
            </path>
          </svg>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("user_input", %{"value" => value}, socket) do
    messages =
    socket.assigns[:messages]
    |> List.insert_at(-1, %{type: :sent, body: value})
    {:noreply, assign(socket, messages: messages)}
  end

  defp enter_script() do
    """
    if (shiftPressed) {
      value = value + '\\n';
      return;
    }
    pushEventHook.pushEventTo($el, 'user_input', {value: value});
    value = '';
    """
  end
end
