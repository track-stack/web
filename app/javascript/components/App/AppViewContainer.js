import React, { Component } from 'react';
import { connect, Provider } from 'react-redux';
import AppView from './AppView';
import { store } from 'trackstack';

const ConnectedComponent = connect(
  function() { return {} },
  function() { return {} }
)(AppView)

export default class AppViewContainer extends Component {
  render() {
    console.log('AppViewContainer: rendering...');
    return (
      <Provider store={store}>
        <ConnectedComponent />
      </Provider>
    )
  }
}

