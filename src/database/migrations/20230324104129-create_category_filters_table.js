const tableName = "category_filters";

module.exports = {
  async up(queryInterface, Sequelize) {
    return queryInterface.createTable(tableName, {
      id: {
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.DataTypes.INTEGER,
      },
      createdAt: {
        type: Sequelize.DataTypes.DATE,
      },
      updatedAt: {
        type: Sequelize.DataTypes.DATE,
      },
      parent_category_id: {
        type: Sequelize.DataTypes.INTEGER,
      },
      info: {
        type: Sequelize.DataTypes.JSONB,
        allowNull: true,
      },
    });
  },

  async down(queryInterface, Sequelize) {
    return queryInterface.dropTable(tableName);
  },
};
