import React from 'react';
import { TabContent, TabPane, Nav, NavItem, NavLink } from 'reactstrap';
import ReactDisqusComments from 'react-disqus-comments';
import { translate } from 'react-i18next';
import withActive from '../hoc/withActive.jsx';
import md from '../../lib/markdown';

const SideBar = ({ lesson, activeClass, active, t }) => {
  const theory = md(lesson.theory);
  const instructions = md(lesson.instructions);
  const activate = activeClass('active');

  return (<div className="card hexlet-basics-theory-card">
    <div className="card-header">
      <Nav className="nav nav-pills card-header-pills justify-content-center">
        <NavItem>
          <NavLink href="#" {...activate('lesson', { default: true })}>{t('lesson')}</NavLink>
        </NavItem>
        <NavItem>
          <NavLink href="#" {...activate('discuss')}>{t('discuss')}</NavLink>
        </NavItem>
      </Nav>
    </div>
    <div className="card-body x-overflow-y-scroll">
      <TabContent activeTab={active}>
        <TabPane tabId="lesson">
          <h4>{lesson.name}</h4>
          <div className="card-text" dangerouslySetInnerHTML={{ __html: theory }} />
          <h5 className="card-title">{t('instructions')}</h5>
          <div className="card-text" dangerouslySetInnerHTML={{ __html: instructions }} />
        </TabPane>
        <TabPane tabId="discuss">
          <ReactDisqusComments
            identifier={`lesson-${lesson.id}`}
            shortname="hexlet-basics"
          />
        </TabPane>
      </TabContent>
    </div>
  </div>);
};

export default translate()(withActive(SideBar));
