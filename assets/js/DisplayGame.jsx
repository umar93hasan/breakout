
import React from 'react';
import { Stage, Layer, Rect, Circle, Text } from 'react-konva';

export default function DisplayGame(props) {

  let rects = props.bricks.map((rr) => {
    return <Rect key={"r"+rr.id} x={rr.x} y={rr.y} width={rr.w} height={rr.h} fill= {rr.color} />
  });

  let lives1 = "Lives: " + props.paddle1.lives;
  let lives2 = "Lives: " + props.paddle2.lives;
  let scores1 = "Score: " + props.paddle1.score;
  let scores2 = "Score: " + props.paddle2.score;
  let displayText = "";
  let chatHeader = "Live Chat";
  if(props.player2=="" && props.ball.moveY==0){
    displayText = "Waiting for Player2";
  }else if(props.ball.moveY==0){
    displayText = "Press 'space' to begin.";
  }

  if(props.winner!="na"){
    if(props.winner==props.curPlayer){
      displayText = "You WON!!! Press R to restart";
    }else if(props.winner!=props.curPlayer && (props.curPlayer==props.player1 || props.curPlayer==props.player2)){
      displayText = "You Lost :(";
    }
    else{
      displayText = props.winner + " WON!!"
    }
  }


  let chat = "";
  for(var i=0;i<props.chat.length;i++){
    chat = chat+"\n"+props.chat[i];
  }


  return (
    <Stage width={1100} height={600}>
      <Layer fill='purple'>
        { rects }
        <Circle x={props.ball.x} y={props.ball.y} radius={props.ball.radius} fill='#4286f4' />
        <Rect x={props.paddle1.x} y={props.paddle1.y} width={props.paddle1.w} height={props.paddle1.h} fill= '#40CDC4' />
        <Rect x={props.paddle2.x} y={props.paddle2.y} width={props.paddle2.w} height={props.paddle2.h} fill= 'red' />
        <Text x={20} y={20} text={scores2} fill='white' fontSize='25' />
        <Text x={20} y={50} text={lives2} fill='white' fontSize='25' />
        <Text x={20} y={530} text={scores1} fill='white' fontSize='25' />
        <Text x={20} y={560} text={lives1} fill='white' fontSize='25' />
        <Text x={280} y={450} text={displayText} fill='green' fontSize='25' />
        <Rect x={783} y={0} width={500} height={600} fill= '#4b5059' />
        <Rect x={783} y={0} width={2} height={600} fill= 'black' />
        <Text x={790} y={5} text='Live Chat:' fill='white' fontSize='25' fontStyle='Italic' />
        <Rect x={783} y={34} width={450} height={2} fill= 'black' />
        <Text x={790} y={32} text={chat} fill='white' fontSize='20' fontFamily='Verdana' />
      </Layer>
    </Stage>
  );

}
