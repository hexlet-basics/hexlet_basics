// @ts-check

import { connect } from 'react-redux';
import { actions } from './reducers';

export default (mapStateToProps = () => ({}), mapDispatch = {}) => (Component) => connect(mapStateToProps, { ...actions, ...mapDispatch })(Component);
