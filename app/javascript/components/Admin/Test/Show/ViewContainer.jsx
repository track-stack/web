import React, { Component } from 'react'
import { Provider, connect } from 'react-redux'
import { store, actions } from 'trackstack'
import View from './View'

const {reset, submitAnswer} = actions.Admin;

const mapStateToProps = state => {
  return {
    steps: state.admin.steps
  }
}

const mapDispatchToProps = dispatch => {
  return {
    reset: () => {
      dispatch(reset())
    },
    submitAnswer: (answer) => {
      dispatch(submitAnswer(answer))
    },
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
