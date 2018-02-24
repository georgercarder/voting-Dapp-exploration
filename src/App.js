import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
					<img className='App-logo' src={logo} alt='logo'  />					
          <h1 className="App-title">BlockChain Election</h1>
        </header>
      </div>
    );
  }
}

export default App;
