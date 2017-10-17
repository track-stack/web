import React, { Component } from 'react';

export default class FriendFinderView extends React.Component {
  constructor(props) {
    super(props)

    this.state = { friends: [], selectedFriend: null }

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

  handleClick(friend) {
    this.setState({ selectedFriend: friend })
  }

  render() {
    const friends = this.state.friends.map((friend, idx) => {
      return (
        <li key={idx} onClick={ () => { this.handleClick(friend) }}>
          <img src={friend.picture.data.url} width="30" height="30" />
          {friend.name}
        </li>
      )
    })

    const friendsList = (
      <div className="friends-list selectable">
        <input
          className="form-control"
          type="text"
          placeholder="Find friends"
          onChange={this.queryChanged}
        />
        <ul className="list-unstyled">
          {friends}
        </ul>
      </div>
    )

    const invitee = this.state.selectedFriend ? (
      <div className="invite-list">
        <h4 style={{marginTop: 0}}>Send invitation</h4>
        <div>
          <img src={this.state.selectedFriend.picture.data.url} width="30" height="30" />
          <span>{this.state.selectedFriend.name}</span>
        </div>
        <form action="/games/create" method="post">
          <input name="invitee_uid" value={this.state.selectedFriend.id} type="hidden" />
          <input type="submit" className="btn btn-success" value="Send" />
        </form>
      </div>
    ) : null;

    return (
      <div className="row">
        <div style={{marginTop: 30}}>
          <div className="col-xs-8">
            {friendsList}
          </div>
          <div className="col-xs-4">
            {invitee}
          </div>
        </div>
      </div>
    )
  }
}

