import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Buttons from './Buttons';
import Status from './Status';

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img className='App-logo' src={logo} alt='logo'  />          
          <h1 className="App-title">BlckChain Election</h1>

        </header>
        <Status />
        <Buttons />
      </div>
    );
  }
}

export default App;
