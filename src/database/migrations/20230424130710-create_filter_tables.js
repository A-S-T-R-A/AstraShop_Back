module.exports = {
  async up(queryInterface, Sequelize) {
    queryInterface.dropTable("category_filters");
  },

  async down(queryInterface, Sequelize) {},
};
