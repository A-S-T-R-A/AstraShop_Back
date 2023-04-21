/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
        queryInterface.changeColumn(
          "attribute_values",
          "attribute_type_id",
          {
            type: Sequelize.DataTypes.INTEGER,
            allowNull: false,
            references: {
              model: "attribute_types",
              key: "id",
            },
            onUpdate: "CASCADE",
            onDelete: "CASCADE",
          },
          { transaction: t }
        ),
      ]);
    });
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
        queryInterface.changeColumn("attribute_values", "attribute_type_id", {
          transaction: t,
        }),
      ]);
    });
  },
};
