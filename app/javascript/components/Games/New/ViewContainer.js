import React, { Component } from 'react';
import { Provider } from 'react-redux';
import { store } from 'trackstack';
import { FriendFinderViewContainer } from '../../utils'

export default class ViewContainer extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <FriendFinderViewContainer />
      </Provider>
    )
  }
}
