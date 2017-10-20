import React, { Component } from 'react';

export default class View extends React.Component {
  constructor(props) {
    super(props)
    this.props.fetchGame(this.props.gameId)
  }

  render() {
    let opponents = (<div></div>)
    if (!!this.props.game) {
      const players = this.props.game.players
      console.log(players)
      opponents = (
        <div>
          <p>{players.viewer.name}</p>
          <p>vs</p>
          <p>{players.opponent.name}</p>
        </div>
      )
    }
    return (
      <div>
        {opponents}
      </div>
    )
  }
}
