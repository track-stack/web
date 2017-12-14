/*jshint esversion: 6 */

import React from 'react';
import ReactDOM from 'react-dom';
import ViewContainer from '../../components/Games/Show/ViewContainer';

if (document.getElementById('games-show')) {
  ReactDOM.render(
    <ViewContainer />,
    document.getElementById('games-show')
  );
}
