import React from 'react';
import cn from 'classnames';

export default defaultActive => Component => class Active extends React.Component {
  static defaultProps = {
    onSelectActive: () => {},
  };

  state = { value: defaultActive };

  handleSetActive = value => () => {
    this.setState({ value });
    this.props.onSelectActive(value);
  };

  getCurrent() {
    const { active } = this.props;
    return active || this.state.value;
  }

  activeClass = (activeClassName, defaultClassName = '') => (activeName) => {
    const value = this.getCurrent();
    if (!value) {
      const maybeActiveClass = defaultActive === activeName ? activeClassName : '';
      return cn(defaultClassName, maybeActiveClass);
    } else if (value === activeName) {
      return cn(activeClassName, defaultClassName);
    }

    return defaultClassName;
  }

  render() {
    return (<Component
      {...this.props}
      active={this.getCurrent()}
      activeClass={this.activeClass}
      setActive={this.handleSetActive}
    />);
  }
};
