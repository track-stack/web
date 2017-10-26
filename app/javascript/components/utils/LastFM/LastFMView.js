/*jshint esversion: 6 */

import React, { Component } from 'react';

export default class LastFMView extends React.Component {
  constructor(props) {
    super(props);
    this.state = {text: ""}
    this.timer = null;
  }

  queryChanged = (e) => {
    clearTimeout(this.timer);

    var query = e.target.value;
    this.timer = setTimeout(() => {
      this.performSearch(query)
    }, 500)
  }

  performSearch = query => {
    this.props.performSearch(query)
  }

  render() {
    const searchResults = this.props.searchResults.map((result, index) => {
      const info = `${result.name} - ${result.artist}`
      return <li key={info}>{info}</li>
    });

    return (
      <div>
        <div style={{marginTop: 50}} className="form-group">
          <input
            className="form-control"
            type="text"
            placeholder="Find friends"
            onChange={this.queryChanged}
          />
        </div>

        <ul>
          {searchResults}
        </ul>
      </div>
    )
  }
}

