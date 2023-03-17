/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
        queryInterface.addColumn(
          "product",
          "parent_category_id",
          {
            type: Sequelize.DataTypes.INTEGER,
          },
          { transaction: t }
        ),
        queryInterface.addColumn(
          "product",
          "is_new",
          {
            type: Sequelize.DataTypes.BOOLEAN,
            defaultValue: false,
          },
          { transaction: t }
        ),
        queryInterface.addColumn(
          "product",
          "is_top",
          {
            type: Sequelize.DataTypes.BOOLEAN,
            defaultValue: false,
          },
          { transaction: t }
        ),
        queryInterface.addColumn(
          "product",
          "description",
          {
            type: Sequelize.DataTypes.STRING,
          },
          { transaction: t }
        ),
        queryInterface.addColumn(
          "product",
          "price",
          {
            type: Sequelize.DataTypes.INTEGER,
          },
          { transaction: t }
        ),
        queryInterface.addColumn(
          "product",
          "images",
          {
            type: Sequelize.DataTypes.ARRAY(Sequelize.INTEGER),
          },
          { transaction: t }
        ),
        queryInterface.addColumn(
          "product",
          "attributes",
          {
            type: Sequelize.DataTypes.JSON,
          },
          { transaction: t }
        ),
      ]);
    });
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
        queryInterface.removeColumn("product", "parent_category_id", {
          transaction: t,
        }),
        queryInterface.removeColumn("product", "is_new", {
          transaction: t,
        }),
        queryInterface.removeColumn("product", "is_top", {
          transaction: t,
        }),
        queryInterface.removeColumn("product", "description", {
          transaction: t,
        }),
        queryInterface.removeColumn("product", "price", {
          transaction: t,
        }),
        queryInterface.removeColumn("product", "images", {
          transaction: t,
        }),
        queryInterface.removeColumn("product", "attributes", {
          transaction: t,
        }),
      ]);
    });
  },
};
