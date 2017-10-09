import React, { Component } from 'react';
import { connect } from 'react-redux';
import HomeView from './HomeView';
import { actions } from 'trackstack';

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
)(HomeView)

export default class HomeViewContainer extends React.Component {
  render() {
    return (
      <ConnectedComponent />
    )
  }
}

