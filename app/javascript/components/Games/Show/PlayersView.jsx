/*jshint esversion: 6 */

import React, { Component } from 'react'

export default class PlayersView extends React.Component {
  render() {
    const players = this.props.players
    return (
      <div style={{display: 'flex', justifyContent: 'center', alignItems: 'center'}}>
        <div style={{marginLeft:8, marginRight: 8}}>
          <img src={players.viewer.image} width="50" height="50" />
          <p style={{display: 'none'}} className="float-left"><strong>{players.viewer.name}</strong></p>
        </div>
        <p style={{margin: 0}}><strong>VS.</strong></p>
        <div style={{marginLeft:8, marginRight: 8}}>
          <img src={players.opponent.image} width="50" height="50" />
          <p style={{display: 'none'}} className="float-left"><strong>{players.opponent.name}</strong></p>
        </div>
      </div>
    )
  }
}
