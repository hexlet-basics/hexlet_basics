import { connect } from 'react-redux';
import * as actionCreators from '../actions';
import App from '../components/App.jsx';

const mapStateToProps = (state) => {
  const { notification, checkInfo, currentTabInfo } = state;
  const props = { notification, checkInfo, currentTabInfo };
  return props;
};

export default connect(
  mapStateToProps,
  actionCreators,
)(App);

