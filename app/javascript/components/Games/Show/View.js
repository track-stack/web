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
      <div className="clearfix">
        <p className="float-left"><strong>{players.viewer.name}</strong></p>
        <p className="float-right"><strong>{players.opponent.name}</strong></p>
      </div>
    ) : null;

    const turns = this.props.game ? this.props.game.turns : [];
    const turnListItems = turns.map((turn, index) => {
      return (
        <div className="friends-list">
          <ul className="list-unstyled">
            <li>
              <img src={turn.user_photo} width="30" height="30" />
              {turn.answer}
            </li>
          </ul>
        </div>
      )
    });
    const turnsUI = !!this.props.game ? (
      <ul className="list-unstyled">
        {turnListItems}
      </ul>
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
