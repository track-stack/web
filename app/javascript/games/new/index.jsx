/*jshint esversion: 6 */

import React from 'react';
import ReactDOM from 'react-dom';
import ViewContainer from '../../components/Games/New/ViewContainer';

if (document.getElementById('games-new')) {
  ReactDOM.render(
    <ViewContainer />,
    document.getElementById('games-new')
  );
}
