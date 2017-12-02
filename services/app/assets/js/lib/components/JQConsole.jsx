import React from 'react';
import $ from 'jquery';
import 'jq-console';

const example = `
  <?php

  // BEGIN
  print_r('Winter is coming!');
  // END
`;

export default class App extends React.Component {
  componentDidMount() {
    this.jqconsole = $(this.ref).jqconsole();
    this.jqconsole.Write('[31mRed Text');
    this.jqconsole.Write(example.repeat(10));
  }

  handleRef = (el) => {
    this.ref = el;
  }

  render() {
    return <div ref={this.handleRef} />;
  }
}

