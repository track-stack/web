import React, { Component } from 'react';
import { connect, Provider } from 'react-redux';
import HomeView from './HomeView';
import { actions } from 'trackstack';

const { performSearch } = actions;

const mapStateToProps = (state) => {
  return {
    searchResults: state.searchResults,
  };
}

const mapDispatchToProps = (dispatch) => {
  return {
    performSearch: (text) => {
      dispatch(performSearch(text));
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

