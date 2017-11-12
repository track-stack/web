/*jshint esversion: 6 */

import React, { Component } from 'react'

export default class TurnsListView extends React.Component {
  render() {
    const turns = this.props.turns
    const turnListItems = turns.map((turn, index) => {
      const match = turn.match
      const answer = turn.answer
      const hasNameMatch = turn.hasExactNameMatch
      const hasArtistMatch = turn.hasExactArtistMatch
      const nameColor = hasNameMatch ? "green" : "red"
      const artistColor = hasArtistMatch ? "green" : "red"
      return (
        <li key={index}>
          <img src={turn.userPhoto} width="30" height="30" />
          <strong>{match.name} - {match.artist}</strong> [ <small>input: {turn.answer}</small> ]
          [<small> Name match?: <span style={{color: nameColor}}>{hasNameMatch.toString()}</span>,
            Artist match?: <span style={{color: artistColor}}>{hasArtistMatch.toString()}</span></small>]
        </li>
      )
    });

    return (
      <ul className="list-unstyled">
        {turnListItems}
      </ul>
    )
  }
}
