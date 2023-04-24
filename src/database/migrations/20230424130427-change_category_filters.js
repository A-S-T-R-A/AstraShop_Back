/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
        queryInterface.removeColumn("category_filters", "info", {
          transaction: t,
        }),
        queryInterface.removeColumn("category_filters", "name", {
          transaction: t,
        }),
        queryInterface.removeColumn("category_filters", "type", {
          transaction: t,
        }),
        queryInterface.removeColumn("category_filters", "value", {
          transaction: t,
        }),
      ]);
    });
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {});
  },
};
