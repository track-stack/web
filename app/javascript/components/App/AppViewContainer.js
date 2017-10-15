import React, { Component } from 'react';
import { connect, Provider } from 'react-redux';
import AppView from './AppView';
import { store } from 'trackstack';

export default class AppViewContainer extends Component {
  render() {
    return (
      <Provider store={store}>
        <AppView />
      </Provider>
    )
  }
}

