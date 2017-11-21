/*jshint esversion: 6 */

import React, { Component } from 'react'
import TurnsListView from './TurnsListView'
import PlayersView from './PlayersView'

export default class View extends React.Component {
  constructor(props) {
    super(props)
    this.state = { 
      answer: "", 
      showLogger: false,
      fetchGameTimer: setInterval(() => {
        this.props.fetchGame(this.props.gameId)
      }, 3000)
    }

    this.props.fetchGame(this.props.gameId)

    this.onAnswerChange = this.onAnswerChange.bind(this)
    this.validateAndSubmitAnswer = this.validateAndSubmitAnswer.bind(this)
    this.toggleLogger = this.toggleLogger.bind(this)
  }

  toggleLogger() {
    console.log(this)
    this.setState({ showLogger: !this.state.showLogger })
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

  render() {
    let UI = null

    if (this.props.error) {
      console.log(error)
    }

    if (this.props.game) {
      const players = this.props.game.players

      const stack = this.props.game.lastStack()
      const turns = stack.turns 
      const lastTurn = stack.firstTurn()

      // same player can't go twice in a row
      const disabled = false // stack.ended || (turns.length && lastTurn.userId === players.viewer.id)
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

    const Logger = (
      <div id="logger-container" className={this.state.showLogger ? "show" : ""}ref={(div) => { this.logger = div }}>
        <button className="btn" onClick={this.toggleLogger}>
          {this.state.showLogger ? "hide" : "show"}
        </button>
        <div>
          <div className="container">
            <div className="row">
              <div className="col-xs-12">
                <pre></pre>
              </div>
            </div>
          </div>
        </div>
      </div>
    )

    const padding = this.state.showLogger ? 260 : 60
    return (
      <div style={{paddingTop: padding}}>
        {Logger}
        <div className="col-sm-12">
         {UI}
        </div>
      </div>
    )
  }
}
