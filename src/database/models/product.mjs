import { DataTypes } from "sequelize";

const productModel = {
  id: {
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
  createdAt: {
    type: DataTypes.DATE,
  },
  updatedAt: {
    type: DataTypes.DATE,
  },
};

export function Product(sequelize) {
  return sequelize.define("product", productModel, {
    freezeTableName: true,
  });
}
