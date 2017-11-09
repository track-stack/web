/*jshint esversion: 6 */

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

  validateAndSubmitAnswer(e) {
    e.preventDefault();
    const {answer} = this.state

    // TODO: client side validation

    const gameId = this.props.gameId;
    this.props.submitAnswer({gameId, answer})

    // reset input field
    this.refs.answerField.value = "";
    this.setState({ answer: "" });
  }

  render() {
    let UI = null;

    if (this.props.game) {
      const players = this.props.game.players;
      const opponents = (
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

      const turns = this.props.game.rounds.reduce((acc, round) => {
        return acc.concat(round.turns)
      }, [])
      const disabled = turns.length && turns[turns.length - 1].userId === players.viewer.id
      const turnListItems = turns.map((turn, index) => {
        const match = turn.match
        const answer = turn.answer
        const hasNameMatch = turn.hasExactNameMatch
        const hasArtistMatch = turn.hasExactArtistMatch
        const nameColor = hasNameMatch ? "green" : "red"
        const artistColor = hasArtistMatch ? "green" : "red"
        return (
          <li key={index}>
            <img src={turn.userPhoto} width="30" height="30" />
            <strong>{turn.answer}</strong> [ <small>matched with: {turn.match.name} by {turn.match.artist}</small> ]
            [<small> Name match?: <span style={{color: nameColor}}>{hasNameMatch.toString()}</span>,
              Artist match?: <span style={{color: artistColor}}>{hasArtistMatch.toString()}</span></small>]
          </li>
        )
      });
      const turnsUI = (
        <div>
          <div className="friends-list">
            <ul className="list-unstyled">
              {turnListItems}
            </ul>
          </div>
          <form>
            <div style={{display: 'flex'}} className="form-group">
              <input
                disabled={disabled}
                className="form-control"
                type="text"
                ref="answerField"
                placeholder="Name a song"
                style={{flex: 1}}
                onChange={this.onAnswerChange} />

              <button
                disabled={disabled}
                style={{marginLeft: 15}}
                className="btn btn-success"
                onClick={this.validateAndSubmitAnswer}>
                  Submit answer
              </button>
            </div>
          </form>
        </div>
      )

      UI = (
        <div>
          <div style={{paddingTop: 20, paddingBottom: 16}}>
            {opponents}
          </div>
          {turnsUI}
        </div>
      )
    }

    return (
      <div>
        <div className="col-sm-12">
         {UI}
        </div>
      </div>
    )
  }
}
