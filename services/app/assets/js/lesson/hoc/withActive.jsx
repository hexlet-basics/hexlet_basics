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

  activeClass = (activeClassName, defaultClassName = '') => (activeName) => {
    const { active } = this.props;
    const value = active || this.state.value;
    const onClick = this.handleSetActive(activeName);
    if (!value) {
      const maybeActiveClass = defaultActive === activeName ? activeClassName : '';
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
