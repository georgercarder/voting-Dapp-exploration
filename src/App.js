import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Buttons from './Buttons';

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
					<img className='App-logo' src={logo} alt='logo'  />					
          <h1 className="App-title">BlockChain Election</h1>
        </header>
				<Buttons />
			</div>
    );
  }
}

export default App;
