import React, { Component } from 'react';

export default class FriendFinderView extends React.Component {
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
      return (
        <li key={idx}>
          <img src={friend.picture.data.url} width="30" height="30" />
          {friend.name}
        </li>
    )
    })

    return (
      <div className="friends-list">
        <div style={{marginTop: 30}}>
          <input
            className="form-control"
            type="text"
            placeholder="Find friends"
            onChange={this.queryChanged}
          />
        </div>
        <ul className="list-unstyled">
          {friends}
        </ul>
      </div>
    )
  }
}

