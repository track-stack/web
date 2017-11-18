/*jshint esversion: 6 */

import React, { Component } from 'react'
import TurnsListView from './TurnsListView'
import PlayersView from './PlayersView'

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
    const value = e.currentTarget.value
    this.setState({ answer: value })
  }

  validateAndSubmitAnswer(e) {
    e.preventDefault();

    const {answer} = this.state
    const previousTurn = this.props.game.latestTurn()
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
      const turns = this.props.game.stacks.reduce((acc, stack) => {
        return acc.concat(stack.turns)
      }, [])

      // same player can't go twice in a row
      const disabled = turns.length && turns[turns.length - 1].userId === players.viewer.id

      UI = (
        <div>
          <div style={{paddingTop: 20, paddingBottom: 16}}>
            <PlayersView players={players} />
          </div>
          <div className="friends-list">
            <TurnsListView turns={turns} />
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
