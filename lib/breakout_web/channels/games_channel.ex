defmodule BreakoutWeb.GamesChannel do
  use BreakoutWeb, :channel

  alias Breakout.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      user = payload
      if Breakout.GameBackup.load(name) do
        if user == Breakout.GameBackup.load(name).player1 do
          game = Breakout.GameBackup.load(name)
        else
          game = Breakout.GameBackup.load(name)
          |> Game.addPlayer2(user)
        end
      else
        game = Game.new(user)
      end
      IO.inspect "p1:"
      IO.inspect game.player1
      IO.inspect "p2:"
      IO.inspect game.player2
      Breakout.GameBackup.save(name, game)
      send(self, {:after_join, payload})
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => game}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("movePaddleLeft", param, socket) do
    #game = Game.movePaddleLeft(socket.assigns[:game])
    game = Breakout.GameBackup.load(socket.assigns[:name])
    game = Game.movePaddleLeft(game,param)
    Breakout.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    broadcast socket, "message", %{"game" => game}
    {:noreply, socket}
  end

  def handle_in("movePaddleRight", param, socket) do
    #game = Game.movePaddleRight(socket.assigns[:game])
    game = Breakout.GameBackup.load(socket.assigns[:name])
    game = Game.movePaddleRight(game,param)
    Breakout.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    broadcast socket, "message", %{"game" => game}
    {:noreply, socket}
  end

  def handle_in("startGame", param, socket) do
    #game = Game.movePaddleRight(socket.assigns[:game])
    game = Breakout.GameBackup.load(socket.assigns[:name])
    game = Game.startGame(game)
    Breakout.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    broadcast socket, "message", %{"game" => game}
    send(self, {:play_game, game})
    {:noreply, socket}
  end

  def handle_in("updateGame", param, socket) do
    #game = Game.movePaddleRight(socket.assigns[:game])
    game = Breakout.GameBackup.load(socket.assigns[:name])
    game = Game.moveBall(game)
    Breakout.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    broadcast socket, "message", %{"game" => game}
    {:noreply, socket}
  end

  def handle_in("reset", param, socket) do
    #game = Game.movePaddleRight(socket.assigns[:game])
    game = Breakout.GameBackup.load(socket.assigns[:name])
    game = Game.reset(game)
    Breakout.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    broadcast socket, "message", %{"game" => game}
    {:noreply, socket}
  end

  def handle_in("sendMessage", param, socket) do
    IO.inspect param
    game = Breakout.GameBackup.load(socket.assigns[:name])
    game = Game.chatMsg(game,param)
    Breakout.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    broadcast socket, "message", %{"game" => game}
    {:noreply, socket}
  end

  def handle_info({:after_join, _message}, socket) do
      game = Breakout.GameBackup.load(socket.assigns[:name])
      #game = Game.startGame(game)
      #Breakout.GameBackup.save(socket.assigns[:name], game)
      broadcast socket, "message", %{"game" => game}
      #send(self, {:play_game, game})
      {:noreply, socket}
  end

  def handle_info({:play_game, _message},socket) do
    game = Breakout.GameBackup.load(socket.assigns[:name])
    if game.running do
      game = Game.moveBall(game)
      Breakout.GameBackup.save(socket.assigns[:name], game)
      broadcast socket, "message", %{"game" => game}
      :timer.sleep(30)
      send(self, {:play_game, game})
    end
    {:noreply, socket}
  end
  # Add authorization logic here as required.

  defp authorized?(_payload) do
    true
  end
end
