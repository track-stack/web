import React, { Component } from 'react';
import { Provider, connect } from 'react-redux';
import { store, actions } from 'trackstack';
import View from './View'

const { fetchGame } = actions;

const mapStateToProps = state => {
  return {
    game: state.main.game
  }
}

const mapDispatchToProps = dispatch => {
  return {
    fetchGame: (gameId) => {
      dispatch(fetchGame(gameId))
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
