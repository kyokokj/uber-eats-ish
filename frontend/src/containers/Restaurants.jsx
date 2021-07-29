import React, { Fragment, useEffect } from "react";

// APIs
import { fetchRestaurants } from "../apis/restaurants";

export const Restaurants = () => {
  useEffect(() => {
    fetchRestaurants().then((data) => console.log(data));
  }, []);
  return <Fragment>Restaurants index</Fragment>;
};
