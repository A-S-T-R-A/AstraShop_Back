import { DataTypes } from "sequelize";

export function Product(sequelize) {
  return sequelize.define(
    "product",
    {
      name: {
        type: DataTypes.STRING,
        allowNull: false,
      },
    },
    {
      freezeTableName: true,
    }
  );
}
