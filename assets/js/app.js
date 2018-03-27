// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
//import React from 'react';
//import Appln from './Appln';

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

import breakoutgame_init from "./BreakoutGame";

import MyRect from "./BreakoutGame";

function form_init(){
  $('#game-button').click(() => {
    let xx = $('#game-input').val();
    let user = $('#name-input').val();
    localStorage.setItem('userName', user);
    console.log(xx);
    if(xx!="" && user!=""){
      let channel = socket.channel("games:"+{xx}, user);
      channel.join()
        .receive("ok", resp => {
           window.location.href = "/game/"+xx;
         })
        .receive("error", resp => { console.log("Unable to join : ", resp) });
    }else{
      alert("Enter game and username");
    }
  });
}

function start() {
  let root = document.getElementById('root');
  if(root){
    var username = localStorage['userName'];
    //localStorage.removeItem('userName');
    document.getElementById('user-name').innerHTML = username;
    let channel = socket.channel("games:"+window.gameName,username)
    breakoutgame_init(root,channel);
    $('#msg-button').click(() => {
      let msg = $('#msg-input').val();
      if(msg!=""){
        let textToSend = username+": "+ msg;
        channel.push("sendMessage",textToSend)
        .receive("ok", );
      }else{
        alert("Enter message");
      }
    });
  }
  if (document.getElementById('index-page')){
    form_init();
  }
}

// Now that you are connected, you can join channels with a topic:


$(start);
