/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
        queryInterface.changeColumn(
          "product",
          "images",
          {
            type: Sequelize.DataTypes.ARRAY(Sequelize.DataTypes.STRING),
          },
          { transaction: t }
        ),
        queryInterface.addColumn(
          "product",
          "icon",
          {
            type: Sequelize.DataTypes.STRING,
          },
          { transaction: t }
        ),
      ]);
    });
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
        queryInterface.removeColumn("product", "images", {
          transaction: t,
        }),
        queryInterface.removeColumn("product", "icon", {
          transaction: t,
        }),
      ]);
    });
  },
};
