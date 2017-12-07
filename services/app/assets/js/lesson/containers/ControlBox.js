import { connect } from 'react-redux';
import * as actionCreators from '../actions';
import ControlBox from '../components/ControlBox.jsx';

const mapStateToProps = (state) => {
  const { checkInfo, code, finished } = state;
  const props = { checkInfo, code, finished };
  return props;
};

export default connect(
  mapStateToProps,
  actionCreators,
)(ControlBox);

