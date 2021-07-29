import React, { Fragment } from "react";

export const Foods = ({ match }) => {
  return (
    <Fragment>
      Foods index
      <p>restaurantsId is {match.params.restaurantsId}.</p>
    </Fragment>
  );
};
