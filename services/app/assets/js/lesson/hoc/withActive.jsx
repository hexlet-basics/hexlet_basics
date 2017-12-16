import React from 'react';
import cn from 'classnames';

export default Component => class Active extends React.Component {
  static defaultProps = {
    onSelectActive: () => {},
  };

  state = {};

  handleSetActive = value => () => {
    this.setState({ value });
    this.props.onSelectActive(value);
  };

  activeClass = (activeClassName, defaultClassName = '') => (activeName, params = {}) => {
    const { active } = this.props;
    const value = active || this.state.value;
    const onClick = this.handleSetActive(activeName);
    if (!value) {
      const maybeActiveClass = params.default ? activeClassName : '';
      return { onClick, className: cn(defaultClassName, maybeActiveClass) };
    } else if (value === activeName) {
      return { onClick, className: cn(activeClassName, defaultClassName) };
    }

    return { onClick, className: defaultClassName };
  }

  render() {
    return (<Component
      {...this.props}
      active={this.state.value}
      activeClass={this.activeClass}
      setActive={this.handleSetActive}
    />);
  }
};
