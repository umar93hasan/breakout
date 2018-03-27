
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
