import React, { Component } from 'react';

export default class View extends React.Component {
  constructor(props) {
    super(props)
    this.props.fetchGame(this.props.gameId)
  }

  render() {
    const players = !!this.props.game ? this.props.game.players : null;
    const opponents = players ? (
      <div style={{display: 'flex', justifyContent: 'space-evenly'}}>
        <p><strong>{players.viewer.name}</strong></p>
        <p><strong>vs.</strong></p>
        <p><strong>{players.opponent.name}</strong></p>
      </div>
    ) : null;

    return (
      <div>
        {opponents}
      </div>
    )
  }
}
