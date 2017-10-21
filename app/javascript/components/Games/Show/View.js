import React, { Component } from 'react';

export default class View extends React.Component {
  constructor(props) {
    super(props)
    this.state = { answer: "" }
    this.props.fetchGame(this.props.gameId)

    this.onAnswerChange = this.onAnswerChange.bind(this)
    this.validateAndSubmitAnswer = this.validateAndSubmitAnswer.bind(this)
  }

  onAnswerChange(e) {
    const value = e.currentTarget.value;
    this.setState({ answer: value });
  }

  validateAndSubmitAnswer() {
    const {answer} = this.state

    // TODO: client side validation

    const gameId = this.props.gameId;
    this.props.submitAnswer({gameId, answer})
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

    const turns = this.props.game ? this.props.game.turns : [];
    const turnListItems = turns.map((turn, index) => {
      return <p key={index}>{turn.answer}</p>
    });
    const turnsUI = !!this.props.game ? (
      <ul>
        {turnListItems}
      </ul>
    ) : null;

    return (
      <div>
        {opponents}
        <div className="col-sm-2"></div>
        <div className="col-sm-8">
          {turnsUI}
          <div style={{display: 'flex'}}>
            <input type="text" placeholder="Name a song" style={{flex: 1}} onChange={this.onAnswerChange} />
            <button className="inactive" onClick={this.validateAndSubmitAnswer}>Go</button>
          </div>
        </div>
      </div>
    )
  }
}
