import React from 'react';
import { FriendFinderViewContainer } from '../../utils'

export default class View extends React.Component {
  constructor(props) {
    super(props)

    this.state = { invitee: null }
  }

  render() {
    const authenticityToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    const invitee = this.props.invitee ? (
      <div className="invite-list">
        <h4 style={{marginTop: 0}}>Send invitation</h4>
        <div>
          <img src={this.props.invitee.picture.data.url} width="30" height="30" />
          <span>{this.props.invitee.name}</span>
        </div>
        <form action="/game_invite" method="post">
          <div style={{margin: 0, padding: 0, display: "none"}}>
            <input type="hidden" value={authenticityToken} name="authenticity_token" />
            <input type="hidden" value="post" name="_method" />
          </div>
          <input name="uid" value={this.props.invitee.id} type="hidden" />
          <input type="submit" className="btn btn-success" value="Send" />
        </form>
      </div>
    ) : null;

    return (
      <div className="row">
        <div className="col-xs-8">
          <FriendFinderViewContainer />
        </div>
        <div className="col-xs-4">
          {invitee}
        </div>
      </div>
    )
  }
}

