defmodule Breakout.Game do

  def new(user) do
    state = %{
      player1: user,
      player2: "",
      running: false,
      winner: "na",
      bricks: init_bricks(),
      ball: %{x: 400 , y: 100, radius: 6, moveX: 0, moveY: 0},
      paddle1: %{w: 100 , h: 10, x: 350, y: 590, score: 0, lives: 10},
      paddle2: %{w: 100 , h: 10, x: 350, y: 0, score: 0, lives: 10},
      current: 0,
      ballspeed: false,
      ballradius: false,
      paddlelength: false,
      chat: []
    }
    state
  end

  def addPlayer2(game,user) do
    if game.player2 == "" do
      game=Map.replace!(game,:player2,user)
    end
    game
  end

  def startGame(game) do
    ball = game.ball
    |>Map.replace(:moveY,5)
    Map.replace!(game,:ball,ball)
    |> Map.replace!(:running,true)
  end

  def init_bricks() do
    brick_x = 2
    brick_y = 270
    random_number = :rand.uniform(3)

    if random_number == 2 do
      bricks = for i<- 0..89 do
        ii = rem(i,15)
        brick_x = 52*ii + 2
        cond do
          i<15 ->
            brick = %{id: i, x: brick_x, y: brick_y, w: 50, h: 10, color: "green", bonuscode: "NIL"}
          i<30 ->
            cond do
              i==15 -> brick = %{id: i, x: brick_x, y: brick_y+12, w: 50, h: 10, color: "#3040DE", bonuscode: "PADDLE"}
              i==29 -> brick = %{id: i, x: brick_x, y: brick_y+12, w: 50, h: 10, color: "#3040DE", bonuscode: "BALL"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+12, w: 50, h: 10, color: "orange", bonuscode: "NIL"}
            end
          i<45 ->
            cond do
              i==35 -> brick = %{id: i, x: brick_x, y: brick_y+24, w: 50, h: 10, color: "#3040DE", bonuscode: "SPEED"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+24, w: 50, h: 10, color: "gold", bonuscode: "NIL"}
            end
          i<60 ->
            cond do
              i==54 -> brick = %{id: i, x: brick_x, y: brick_y+36, w: 50, h: 10, color: "#3040DE", bonuscode: "SPEED"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+36, w: 50, h: 10, color: "gold", bonuscode: "NIL"}
            end
          i<75 ->
            cond do
              i==72 -> brick = %{id: i, x: brick_x, y: brick_y+48, w: 50, h: 10, color: "#3040DE", bonuscode: "PADDLE"}
              i==62 -> brick = %{id: i, x: brick_x, y: brick_y+48, w: 50, h: 10, color: "#3040DE", bonuscode: "BALL"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+48, w: 50, h: 10, color: "orange", bonuscode: "NIL"}
            end
          true -> brick = %{id: i, x: brick_x, y: brick_y+60, w: 50, h: 10, color: "green", bonuscode: "NIL"}
        end
        brick
      end
    end

    if random_number == 1 do
      bricks = for i<- 0..89 do
        ii = rem(i,15)
        brick_x = 52*ii + 2
        cond do
          i<15 ->
            brick = %{id: i, x: brick_x, y: brick_y, w: 50, h: 10, color: "orange", bonuscode: "NIL"}
          i<30 ->
            cond do
              i==15 -> brick = %{id: i, x: brick_x, y: brick_y+12, w: 50, h: 10, color: "#3040DE", bonuscode: "PADDLE"}
              i==29 -> brick = %{id: i, x: brick_x, y: brick_y+12, w: 50, h: 10, color: "#3040DE", bonuscode: "BALL"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+12, w: 50, h: 10, color: "orange", bonuscode: "NIL"}
            end
          i<45 ->
            cond do
              i==35 -> brick = %{id: i, x: brick_x, y: brick_y+24, w: 50, h: 10, color: "#3040DE", bonuscode: "SPEED"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+24, w: 50, h: 10, color: "gold", bonuscode: "NIL"}
            end
          i<60 ->
            cond do
              i==54 -> brick = %{id: i, x: brick_x, y: brick_y+36, w: 50, h: 10, color: "#3040DE", bonuscode: "SPEED"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+36, w: 50, h: 10, color: "gold", bonuscode: "NIL"}
            end
          i<75 ->
            cond do
              i==72 -> brick = %{id: i, x: brick_x, y: brick_y+48, w: 50, h: 10, color: "#3040DE", bonuscode: "PADDLE"}
              i==62 -> brick = %{id: i, x: brick_x, y: brick_y+48, w: 50, h: 10, color: "#3040DE", bonuscode: "BALL"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+48, w: 50, h: 10, color: "orange", bonuscode: "NIL"}
            end
          true -> brick = %{id: i, x: brick_x, y: brick_y+60, w: 50, h: 10, color: "orange", bonuscode: "NIL"}
        end
        brick
      end
    end

    if random_number == 3 do
      bricks = for i<- 0..89 do
        ii = rem(i,15)
        brick_x = 52*ii + 2
        cond do
          i<15 ->
            brick = %{id: i, x: brick_x, y: brick_y, w: 50, h: 10, color: "green", bonuscode: "NIL"}
          i<30 ->
            cond do
              i==15 -> brick = %{id: i, x: brick_x, y: brick_y+12, w: 50, h: 10, color: "#3040DE", bonuscode: "PADDLE"}
              i==29 -> brick = %{id: i, x: brick_x, y: brick_y+12, w: 50, h: 10, color: "#3040DE", bonuscode: "BALL"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+12, w: 50, h: 10, color: "green", bonuscode: "NIL"}
            end
          i<45 ->
            cond do
              i==35 -> brick = %{id: i, x: brick_x, y: brick_y+24, w: 50, h: 10, color: "#3040DE", bonuscode: "SPEED"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+24, w: 50, h: 10, color: "gold", bonuscode: "NIL"}
            end
          i<60 ->
            cond do
              i==54 -> brick = %{id: i, x: brick_x, y: brick_y+36, w: 50, h: 10, color: "#3040DE", bonuscode: "SPEED"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+36, w: 50, h: 10, color: "gold", bonuscode: "NIL"}
            end
          i<75 ->
            cond do
              i==72 -> brick = %{id: i, x: brick_x, y: brick_y+48, w: 50, h: 10, color: "#3040DE", bonuscode: "PADDLE"}
              i==62 -> brick = %{id: i, x: brick_x, y: brick_y+48, w: 50, h: 10, color: "#3040DE", bonuscode: "BALL"}
              true -> brick = %{id: i, x: brick_x, y: brick_y+48, w: 50, h: 10, color: "green", bonuscode: "NIL"}
            end
          true -> brick = %{id: i, x: brick_x, y: brick_y+60, w: 50, h: 10, color: "green", bonuscode: "NIL"}
        end
          brick
      end
    end

    bricks
  end

  def reset(game) do
    newgame = new(game.player1)
    |> addPlayer2(game.player2)
    newgame
  end

  def brickHit(game) do
    #bricksnew = game.bricks;
    bricks = game.bricks;
    ball = game.ball;
    current = game.current;
    paddlelength = game.paddlelength;
    ballspeed = game.ballspeed;
    ballradius = game.ballradius;

    blength = length(bricks)-1;
    bricks_new = for i<- 0..blength do
      #IO.inspect bricks
      brick = Enum.at(bricks,i)
      #IO.inspect brick
      cond do
        (brick.x < ball.x+ball.radius && ball.x-ball.radius < brick.x + brick.w) &&
        ball.radius > brick.y - ball.y &&
        brick.y-ball.y > 0 &&
        ball.moveY > 0 ->
          %{id: brick.id, x: brick.x, y: brick.y, w: brick.w, h: brick.h, color: brick.color, bonuscode: brick.bonuscode,dir: 0}
        (brick.x < ball.x+ball.radius && ball.x-ball.radius < brick.x + brick.w) &&
        ball.radius > ball.y - brick.y - brick.h &&
        ball.y- brick.y + brick.h > 0 &&
        ball.moveY < 0 ->
          %{id: brick.id, x: brick.x, y: brick.y, w: brick.w, h: brick.h, color: brick.color, bonuscode: brick.bonuscode,dir: 1}
        true ->
          nil
      end
    end

    cur_brick = Enum.at(Enum.filter(bricks_new, & &1),0)

    if cur_brick==nil do
    else
      if cur_brick.dir==0 do
        brick = Map.delete(cur_brick, :dir)
        if ballspeed == true do
          ball = Map.replace!(ball, :moveY, ball.moveY-2)
          game = Map.replace!(game, :ballspeed, false)
        end
        if ballradius == true do
          ball = Map.replace!(ball, :radius, ball.radius-3)
          game = Map.replace!(game, :ballradius, false)
        end
        if brick.color =="gold" do
          game = Map.replace!(game, :current, current+50)
        end
        if brick.color =="orange" do
          game = Map.replace!(game, :current, current+30)
        end
        if brick.color=="green" do
          game = Map.replace!(game, :current, current+10)
        end
        if brick.bonuscode=="SPEED" do
          ball = Map.replace!(ball, :moveY, ball.moveY+2)
          game = Map.replace!(game, :ballspeed, true)
        end
        if brick.bonuscode=="BALL" do
          ball = Map.replace!(ball, :radius, ball.radius+3)
          game = Map.replace!(game, :ballradius, true)
        end
        if brick.bonuscode=="PADDLE" do
          game = Map.replace!(game, :paddlelength, true)
        end
        ball = Map.replace!(ball, :moveY, -ball.moveY)
        #bricks.splice(i,1);
        #IO.inspect brick
        game=Map.replace!(game, :bricks, List.delete(bricks,brick))
        #brick=%{}
      end
      if cur_brick.dir==1 do
        brick = Map.delete(cur_brick, :dir)
          if ballspeed == true do
            ball = Map.replace!(ball, :moveY, ball.moveY+2)
            game = Map.replace!(game, :ballspeed, false)
          end
          if ballradius == true do
            ball = Map.replace!(ball, :radius, ball.radius-3)
            game = Map.replace!(game, :ballradius, false)
          end
          if brick.color =="gold" do
            game = Map.replace!(game, :current, current+50)
          end
          if brick.color =="orange" do
            game = Map.replace!(game, :current, current+30)
          end
          if brick.color=="green" do
            game = Map.replace!(game, :current, current+10)
          end
          if brick.bonuscode=="SPEED" do
            ball = Map.replace!(ball, :moveY, ball.moveY-2)
            game = Map.replace!(game, :ballspeed, true)
          end
          if brick.bonuscode=="BALL" do
            ball = Map.replace!(ball, :radius, ball.radius+3)
            game = Map.replace!(game, :ballradius, true)
          end
          if brick.bonuscode=="PADDLE" do
            game = Map.replace!(game, :paddlelength, true)
          end
          ball = Map.replace!(ball, :moveY, -ball.moveY)
          #bricks.r
          game=Map.replace!(game, :bricks, List.delete(bricks,brick))
          #bricks.splice(i,1);
          #Enum.drop(bricks,i)
      end
    end
    game = Map.replace!(game, :ball, ball)
    game
  #IO.inspect cur_brick, charlists: :as_lists
  end

  def movePaddleLeft(game,user) do
    if user == game.player1 do
      p=Map.replace!(game.paddle1,:x,game.paddle1.x-5)
      game=Map.replace!(game,:paddle1,p)
    end
    if user == game.player2 do
      p=Map.replace!(game.paddle2,:x,game.paddle2.x-5)
      game=Map.replace!(game,:paddle2,p)
    end
    game
  end

  def movePaddleRight(game,user) do
    if user == game.player1 do
      p=Map.replace!(game.paddle1,:x,game.paddle1.x+5)
      game=Map.replace!(game,:paddle1,p)
    end
    if user == game.player2 do
      p=Map.replace!(game.paddle2,:x,game.paddle2.x+5)
      game=Map.replace!(game,:paddle2,p)
    end
    game
  end

  def moveBall(game) do
    ball = game.ball
    ball = Map.replace!(ball, :x, ball.x+ball.moveX)
    ball = Map.replace!(ball, :y, ball.y+ball.moveY)

    game = Map.replace!(game, :ball, ball)
    game=wallRebound(game)
    game=brickHit(game)
    cond do
      game.paddle1.lives == 0 ->
        game = Map.replace!(game,:running,false)
        |> Map.replace!(:winner,game.player2)
      game.paddle2.lives == 0 ->
        game = Map.replace!(game,:running,false)
        |> Map.replace!(:winner,game.player1)
      length(game.bricks) == 0 ->
        if game.paddle1.score > game.paddle2.score do
          game = Map.replace!(game,:running,false)
          |> Map.replace!(:winner,game.player1)
        else
          game = Map.replace!(game,:running,false)
          |> Map.replace!(:winner,game.player2)
        end
      true ->
        game=paddleHit(game)
    end

    game
  end


  def wallRebound(game) do
    ball = game.ball
    paddle1 = game.paddle1
    paddle2 = game.paddle2
    cond do
      ball.x < 0 || ball.x >=783 ->
        ball = Map.replace!(ball, :moveX, -ball.moveX)
      ball.y < 0 ->
        ball = Map.replace!(ball, :y, 400)
        |> Map.replace!(:moveX, 0)
        |> Map.replace!(:moveY, -ball.moveY)
        paddle2 = Map.replace!(paddle2, :lives, paddle2.lives-1)
      ball.y > 600 ->
        ball = Map.replace!(ball, :y, 200)
        |> Map.replace!(:moveX, 0)
        |> Map.replace!(:moveY, -ball.moveY)
        paddle1 = Map.replace!(paddle1, :lives, paddle1.lives-1)
      true ->
    end
    game = Map.replace!(game, :ball, ball)
    |> Map.replace!(:paddle1, paddle1)
    |> Map.replace!(:paddle2, paddle2)
    game
  end

  def paddleHit(game) do
    ball = game.ball;
    paddle1 = game.paddle1;
    paddle2 = game.paddle2;
    current = game.current;
    paddlelength = game.paddlelength;
    diff1 = ball.x-paddle1.x;
    diff2 = ball.x-paddle2.x;
    cond do
      ball.y>=590 && (diff1>0 && diff1<paddle1.w) ->
        if paddlelength == false && paddle1.w >100 do
          paddle1 = Map.replace!(paddle1, :w, paddle1.w-50)
        end
        if paddlelength == true && paddle1.w == 100 do
          paddle1 = Map.replace!(paddle1, :w, paddle1.w+50)
          game = Map.replace!(game, :paddlelength, false)
        end
        direction = ball.x - (paddle1.x + paddle1.w/2)
        ball = Map.replace!(ball, :moveX, direction*0.15)
        |> Map.replace!(:moveY, -ball.moveY)
        paddle1 = Map.replace!(paddle1, :score, paddle1.score+current)
        current = 0
      ball.y<=10 && (diff2 > 0 && diff2 < paddle2.w) ->
        if paddlelength == false && paddle2.w >100 do
          paddle2 = Map.replace!(paddle2, :w, paddle2.w-50)
        end
        if paddlelength == true && paddle2.w == 100 do
          paddle2 = Map.replace!(paddle2, :w, paddle2.w+50)
          game = Map.replace!(game, :paddlelength, false)
        end
        direction = ball.x - (paddle2.x + paddle2.w/2)
        ball = Map.replace!(ball, :moveX, direction*0.15)
        |> Map.replace!(:moveY, -ball.moveY)
        paddle2 = Map.replace!(paddle2, :score, paddle2.score+current)
        current = 0
        true ->
    end
    game = Map.replace!(game, :ball, ball)
    |> Map.replace!(:paddle1, paddle1)
    |> Map.replace!(:paddle2, paddle2)
    |> Map.replace!(:current, current)
    game
  end

  def chatMsg(game, msg) do
    chat = game.chat
    IO.inspect chat
    if length(chat) < 25 do
      chat = chat ++ [msg]
    else
      [h|chat] = chat
      chat = chat ++ [msg]
    end
    Map.replace!(game, :chat, chat)
  end

end
