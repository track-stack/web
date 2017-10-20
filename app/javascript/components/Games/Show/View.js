import React, { Component } from 'react';

export default class View extends React.Component {
  constructor(props) {
    super(props)
    this.props.fetchGame(this.props.gameId)
  }

  render() {
    const players = !!this.props.game ? this.props.game.players : null;
    const opponents = players ? (
      <div>
        <p>{players.viewer.name}</p>
        <p>vs</p>
        <p>{players.opponent.name}</p>
      </div>
    ) : null;

    return (
      <div>
        {opponents}
      </div>
    )
  }
}
