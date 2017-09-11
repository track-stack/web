import React, { Component } from 'react';
import { connect, Provider } from 'react-redux';
import HomeView from './HomeView';
import { actions } from 'trackstack';

const { saySomething } = actions;

const mapStateToProps = (state) => {
  return {
    thingSaid: state.thingSaid,
  };
}

const mapDispatchToProps = (dispatch) => {
  return {
    saySomething: (text) => {
      dispatch(saySomething(text));
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

