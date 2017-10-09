import React, { Component } from 'react';

export default class HomeView extends React.Component {
  constructor(props) {
    super(props)

    this.state = { friends: [] }

    // fetch friends!
    this.props.fetchFriends()

    this.queryChanged = this.queryChanged.bind(this)
  }

  queryChanged(e) {
    const query = e.target.value.toLowerCase()
    if (query.trim() === '') {
      this.setState({ friends: [] })
      return
    }

    const friends = this.props.friends.filter(friend => {
      return friend.name.toLowerCase().startsWith(query)
    })
    this.setState({ friends: friends })
  }

  render() {
    const friends = this.state.friends.map((friend, idx) => {
      return (<li key={idx}>{friend.name}</li>)
    })

    return (
      <div>
        <div style={{marginTop: 30}}>
          <input
            className="form-control"
            type="text"
            placeholder="Find friends"
            onChange={this.queryChanged}
          />
        </div>
        <ul>
          {friends}
        </ul>
      </div>
    )
  }
}

