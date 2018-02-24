import React, { Component } from 'react';

class Status extends Component {
  render() {
    return (
      <div className="App">
          <h1 className="App-title">Status</h1>
          <ul>
            <li>role</li>
            <li>voted</li>
            <li>delegate count</li>
            <li>Proposals</li>
          </ul>
      </div>
    );
  }
}

export default Status;
