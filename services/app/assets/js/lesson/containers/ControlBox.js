import { connect } from 'react-redux';
import * as actionCreators from '../actions';
import ControlBox from '../components/ControlBox.jsx';

const mapStateToProps = (state) => {
  const { checkInfo } = state;
  const props = { checkInfo };
  return props;
};

export default connect(
  mapStateToProps,
  actionCreators,
)(ControlBox);

