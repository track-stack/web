import React, { Component } from 'react'

export default class View extends React.Component {
  _handleKeyPress(e) {
    if (e.key === "Enter") {
      // submit input
    }
  }

  render() {
    return (
      <div className="form-group">
        <input type="text" className="form-control" onKeyPress={this._handleKeyPress} />
      </div>
    )
  }
}
