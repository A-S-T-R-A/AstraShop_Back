const tableName = "order_products";

module.exports = {
  async up(queryInterface, Sequelize) {
    return queryInterface.createTable(tableName, {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.DataTypes.INTEGER,
      },
      order_id: {
        type: Sequelize.DataTypes.INTEGER,
        allowNull: false,
      },
      product_id: {
        type: Sequelize.DataTypes.INTEGER,
        allowNull: false,
      },
      createdAt: {
        type: Sequelize.DataTypes.DATE,
      },
      updatedAt: {
        type: Sequelize.DataTypes.DATE,
      },
    });
  },

  async down(queryInterface, Sequelize) {
    return queryInterface.dropTable(tableName);
  },
};
