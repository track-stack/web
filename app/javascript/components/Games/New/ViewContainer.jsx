/*jshint esversion: 6 */

import React, { Component } from 'react';
import { Provider, connect } from 'react-redux';
import { store } from 'trackstack';
import View from './View'

const mapStateToProps = state => {
  return {
    invitee: state.main.invitee
  }
}

const mapDispatchToProps = dispatch => {
  return {
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
