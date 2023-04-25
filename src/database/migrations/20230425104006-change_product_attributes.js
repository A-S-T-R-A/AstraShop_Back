const tableName = "product_attributes";
/** @type {import('sequelize-cli').Migration} */

module.exports = {
  async up(queryInterface, Sequelize) {
    return queryInterface.addIndex(
      "product_attributes",
      ["product_id", "product_attribute_value_id"],
      {
        unique: true,
      }
    );
  },

  async down(queryInterface, Sequelize) {},
};
