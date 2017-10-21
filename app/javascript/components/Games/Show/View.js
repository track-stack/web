import React, { Component } from 'react';

export default class View extends React.Component {
  constructor(props) {
    super(props)
    this.state = { answer: "", fetchGameTimer: setInterval(() => {
      this.props.fetchGame(this.props.gameId)
    }, 3000)}
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
    ) : null;

    const turns = this.props.game ? this.props.game.turns : [];
    const turnListItems = turns.map((turn, index) => {
      return (
        <li key={index}>
          <img src={turn.user_photo} width="30" height="30" />
          {turn.answer}
        </li>
      )
    });
    const turnsUI = !!this.props.game ? (
      <div className="friends-list">
        <ul className="list-unstyled">
          {turnListItems}
        </ul>
      </div>
    ) : null;

    return (
      <div>
        <div className="col-sm-12">
          <div style={{paddingTop: 20, paddingBottom: 16}}>
            {opponents}
          </div>
          {turnsUI}
          <div style={{display: 'flex'}} className="form-group">
            <input className="form-control" type="text" placeholder="Name a song" style={{flex: 1}} onChange={this.onAnswerChange} />
            <button style={{marginLeft: 15}} className="btn btn-success" onClick={this.validateAndSubmitAnswer}>Submit answer</button>
          </div>
        </div>
      </div>
    )
  }
}
