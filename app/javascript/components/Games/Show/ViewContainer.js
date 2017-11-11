/*jshint esversion: 6 */

import React, { Component } from 'react';
import { Provider, connect } from 'react-redux';
import { store, actions } from 'trackstack';
import View from './View'

const { fetchGame, submitAnswer } = actions;

const mapStateToProps = state => {
  return {
    game: state.main.game,
    gameId: window.gameId
  }
}

const mapDispatchToProps = dispatch => {
  return {
    fetchGame: (gameId) => {
      dispatch(fetchGame(gameId))
    },
    submitAnswer: ({gameId, answer, previousAnswer}) => {
      dispatch(submitAnswer({gameId, answer, previousAnswer}))
    }
  }
}

const ConnectedComponent = connect(
  mapStateToProps,
  mapDispatchToProps
)(View)

export default class ViewContainer extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <ConnectedComponent />
      </Provider>
    )
  }
}
