import React, { Component } from 'react';

export default class HomeView extends React.Component {
  constructor(props) {
    super(props);
    this.state = {text: ""}
  }

  updateStuff = (e) => {
    this.props.saySomething(e.target.value)
  }

  render() {

    const label = this.props.thingSaid ? (
      <p style={{marginTop:30}}> {this.props.thingSaid} </p>) :
      null

    return (
      <div style={{marginTop: 50}} className="form-group">
        <input
          className="form-control"
          type="text"
          placeholder="Say something!"
          onChange={this.updateStuff}
        />
      {label}
      </div>
    )
  }
}

