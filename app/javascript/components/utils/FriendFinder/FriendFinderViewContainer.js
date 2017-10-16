import React, { Component } from 'react';
import { connect } from 'react-redux';
import { actions } from 'trackstack';
import FriendFinderView from './FriendFinderView';

const { fetchFriends } = actions;

const mapStateToProps = (state) => {
  return {
    friends: state.main.friends
  };
}

const mapDispatchToProps = (dispatch) => {
  return {
    fetchFriends: () => {
      dispatch(fetchFriends());
    }
  }
}

const ConnectedComponent = connect(
  mapStateToProps,
  mapDispatchToProps
)(FriendFinderView)

export default class FriendFinderViewContainer extends React.Component {
  render() {
    return (
      <ConnectedComponent />
    )
  }
}
