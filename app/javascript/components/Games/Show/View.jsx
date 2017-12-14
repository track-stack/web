/*jshint esversion: 6 */

import React, { Component } from 'react'
import TurnsListView from './TurnsListView'
import PlayersView from './PlayersView'

export default class View extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      answer: "",
      fetchGameTimer: setInterval(() => {
        this.props.fetchGame(this.props.gameId)
      }, 3000)
    }

    this.props.fetchGame(this.props.gameId)

    this.onAnswerChange = this.onAnswerChange.bind(this)
    this.validateAndSubmitAnswer = this.validateAndSubmitAnswer.bind(this)
  }

  onAnswerChange(e) {
    const value = e.currentTarget.value
    this.setState({ answer: value })
  }

  validateAndSubmitAnswer(e) {
    e.preventDefault();

    const {answer} = this.state
    const previousTurn = this.props.game.firstTurn()
    const stacks = this.props.game.stacks
    const latestStack = stacks[stacks.length - 1]

    this.props.submitAnswer(answer, latestStack)

    // reset input field
    this.refs.answerField.value = ""
    this.setState({ answer: "" })
  }

  componentWillReceiveProps(nextProps) {
    if (!this.props.error && nextProps.error) {
      alert(nextProps.error)
    }
  }

  render() {
    let UI = null

    if (this.props.game) {
      const players = this.props.game.players
      const stack = this.props.game.lastStack()
      const turns = stack.turns
      const lastTurn = stack.firstTurn()

      // same player can't go twice in a row
      const disabled = stack.ended || (turns.length && lastTurn.userId === players.viewer.id)
      const gameOver = stack.ended

      const authenticityToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      const newStackUrl = `/games/${this.props.game.id}/stacks`
      const gameOverView = gameOver ? (
        <div>
          <p>stack over</p>
          <form action={newStackUrl} method="post">
            <div style={{margin: 0, padding: 0, display: "none"}}>
              <input type="hidden" value={authenticityToken} name="authenticity_token" />
              <input type="hidden" value="post" name="_method" />
            </div>
            <input type="submit" className="btn btn-success" value="New Stack!" />
          </form>
        </div>
      ) : null

      UI = (
        <div>
          <div style={{paddingTop: 20, paddingBottom: 16}}>
            <PlayersView players={players} />
          </div>
          { gameOverView }
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
          <div className="friends-list">
            <TurnsListView turns={turns} />
          </div>
        </div>
      )
    }

    return (
      <div className="row">
        <div className="col-sm-12">
         {UI}
        </div>
      </div>
    )
  }
}
