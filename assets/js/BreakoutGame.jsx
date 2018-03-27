
//Importing required files
import React from 'react'
import ReactDOM from 'react-dom';
import { Component } from 'react';
import { render } from 'react-dom';
import Konva from 'konva';
import { Stage, Layer, Rect, Circle } from 'react-konva';
import DisplayGame from './DisplayGame';

export default function breakoutgame_init(root, channel) {
  ReactDOM.render(<MyRect channel={channel} />, root);
}


class MyRect extends React.Component {
    constructor(props) {
      super(props);
      this.channel = props.channel;
      this.state = {
        player1: "na",
        player2: "na",
        running: false,
        bricks: [],
        ball: {x: 400 , y: 100, radius: 6, moveX:0, moveY:0},
        paddle1: {w: 100 , h: 10, x: 350, y:590, score:0, lives:10},
        paddle2: {w: 100 , h: 10, x: 350, y:0, score:0, lives:10},
        current: 0,
        ballspeed: false,
        ballradius: false,
        paddlelength: false,
        chat: []
      };
      this.handleKeyPress = this.handleKeyPress.bind(this);
      this.channel.join()
          .receive("ok", this.gotView.bind(this))
          .receive("error", resp => { console.log("Unable to join", resp) });
    }

    gotView(view) {
      this.setState(view.game);
    }

    move(){
      var ball = this.state.ball;
      ball.x = ball.x+ball.moveX;
      ball.y = ball.y+ball.moveY;
      this.wallRebound();
      this.paddeHit();
      this.brickHit();
      this.setState({
        ball: ball
      });

    }

    wallRebound(){
      var ball = this.state.ball;
      var paddle1 = this.state.paddle1;
      var paddle2 = this.state.paddle2;
      if(ball.x<=0 || ball.x>=783){
        ball.moveX = -ball.moveX;
        this.setState({
          ball: ball
        });
      }else if(ball.y < 0){
        ball.y = 580;
        ball.moveX = 0;
        paddle2.lives-=1;
        this.setState({
          ball: ball,
          paddle2: paddle2
        });
      }else if(ball.y > 600){
        ball.y = 20;
        ball.moveX = 0;
        paddle1.lives-=1;
        this.setState({
          ball: ball,
          paddle1: paddle1
        });
      }
    }

    paddeHit(){
      var ball = this.state.ball;
      var paddle1 = this.state.paddle1;
      var paddle2 = this.state.paddle2;
      var current = this.state.current;
      var paddlelength = this.state.paddlelength;
      var diff1 = ball.x-paddle1.x;
      var diff2 = ball.x-paddle2.x;
      if(ball.y>=590 && (diff1 > 0 && diff1 < 100)){
        if(paddlelength == false && paddle1.w > 100){
          paddle1.w -= 50;
        }
        if(paddlelength == true && paddle1.w == 100){
          paddle1.w += 50;
          paddlelength = false;
        }
        ball.moveY = -ball.moveY;
        var direction = ball.x - (paddle1.x + 50)
        ball.moveX = direction * 0.15;
        paddle1.score += current;
        current = 0;
        this.setState({
          ball: ball,
          current: current,
          paddle1: paddle1,
          paddlelength: paddlelength
        });
      }else if(ball.y<=10 && (diff2 > 0 && diff2 < 100)){
        if(paddlelength == false && paddle2.w > 100){
          paddle2.w -= 50;
        }
        if(paddlelength == true && paddle2.w == 100){
          paddle2.w += 50;
          paddlelength = false;
        }
        ball.moveY = -ball.moveY;
        var direction = ball.x - (paddle2.x + 50)
        ball.moveX = direction * 0.15;
        paddle2.score += current;
        current = 0;
        this.setState({
          ball: ball,
          current: current,
          paddle2: paddle2,
          paddlelength: paddlelength
        });
      }
    }

    brickHit(){
      var bricks = this.state.bricks;
      var ball = this.state.ball;
      var current = this.state.current;
      var ballspeed = this.state.ballspeed;
      var ballradius = this.state.ballradius;
      var paddlelength = this.state.paddlelength;
      for(var i=0;i<bricks.length;i++){
        if((bricks[i].x < ball.x && ball.x < bricks[i].x+bricks[i].w)
        &&  ball.radius > bricks[i].y-ball.y
        &&  bricks[i].y-ball.y >0
        &&  ball.moveY>0){
          if(ballspeed== true){
            ball.moveY-=5;
            ballspeed = false;
          }
          if(ballradius== true){
            ball.radius-=5;
            ballradius = false;
          }
          if(bricks[i].color=="gold"){
            current+=50;
          }
          else if(bricks[i].color=="orange"){
            current+=30;
          }
          else if(bricks[i].color=="green"){
            current+=10;
          }
          else if(bricks[i].bonuscode=="SPEED"){
            ball.moveY+=5;
            ballspeed = true;
          }
          else if(bricks[i].bonuscode=="BALL"){
            ball.radius+=5;
            ballradius = true;
          }
          else if(bricks[i].bonuscode=="PADDLE"){
            paddlelength = true;
          }
          ball.moveY = -ball.moveY;
          bricks.splice(i,1);
          this.setState({
            ball: ball,
            bricks: bricks,
            current: current,
            ballspeed: ballspeed,
            ballradius: ballradius,
            paddlelength: paddlelength
          });
        }
        else if((bricks[i].x < ball.x && ball.x < bricks[i].x+bricks[i].w)
        &&  ball.radius > ball.y-bricks[i].y-bricks[i].h
        &&  ball.y-bricks[i].y+bricks[i].h > 0
        &&  ball.moveY < 0){
          if(ballspeed== true){
            ball.moveY+=5;
            ballspeed = false;
          }
          if(ballradius== true){
            ball.radius-=5;
            ballradius = false;
          }
          if(bricks[i].color=="gold"){
            current+=50;
          }
          else if(bricks[i].color=="orange"){
            current+=30;
          }
          else if(bricks[i].color=="green"){
            current+=10;
          }
          else if(bricks[i].bonuscode=="SPEED"){
            console.log("Inside 2nd" + i)
            ball.moveY-=5;
            ballspeed = true;
          }
          else if(bricks[i].bonuscode=="BALL"){
            ball.radius+=5;
            ballradius = true;
          }
          else if(bricks[i].bonuscode=="PADDLE"){
            paddlelength = true;
          }
          ball.moveY = -ball.moveY;
          bricks.splice(i,1);
          this.setState({
            ball: ball,
            bricks: bricks,
            current: current,
            ballspeed: ballspeed,
            ballradius: ballradius,
            paddlelength: paddlelength
          });
        }
      }
    }

    handleKeyPress(e) {
      //requestAnimationFrame(loop());
      var paddle1 = this.state.paddle1;
      var paddle2 = this.state.paddle2;
      console.log("key press: " + e.keyCode);
      if(this.channel.params==this.state.player1 || this.channel.params==this.state.player2){
        if(e.keyCode==37){
          if((paddle1.x!=0 && this.channel.params==this.state.player1) || (paddle2.x!=0 && this.channel.params==this.state.player2)){
            this.channel.push("movePaddleLeft",this.channel.params)
            .receive("ok", );
          }
        }
        if(e.keyCode==39){
          if((paddle1.x!=700 && this.channel.params==this.state.player1) || (paddle2.x!=700 && this.channel.params==this.state.player2)){
            this.channel.push("movePaddleRight",this.channel.params)
            .receive("ok", );
          }
        }
        if(e.keyCode==32 && this.state.ball.moveY==0 && this.state.player2!=""){
            this.channel.push("startGame",this.channel.params)
            .receive("ok", );
        }
        if(e.keyCode==82 && this.channel.params==this.state.winner){
            this.channel.push("reset",this.channel.params)
            .receive("ok", );
            console.log("reset");
        }
      }
    }


    componentDidMount() {
      document.addEventListener('keydown', this.handleKeyPress);
      this.channel.on("message", msg => this.gotView(msg));
      /*setInterval(() => {
        if((this.state.player2 == this.channel.params || this.state.player1 == this.channel.params) && this.state.running){
          this.channel.push("updateGame",this.channel.params)
          .receive("ok", );
        }
      }, 50);*/
      //setInterval(this.move.bind(this), 30);
      //setInterval(this.live.bind(this), 1000);
    }

    componentWillUnmount() {
      document.removeEventListener('keydown', this.handleKeyPress);
    }
    render() {
        return (
          <div>
          <DisplayGame root={this} winner={this.state.winner} curPlayer={this.channel.params} player1={this.state.player1} player2={this.state.player2} ball={this.state.ball} bricks={this.state.bricks} paddle1={this.state.paddle1} paddle2={this.state.paddle2} chat={this.state.chat} />
          </div>
        );
    }

}

function App() {
    return (
    <MyRect/>
    );
}
