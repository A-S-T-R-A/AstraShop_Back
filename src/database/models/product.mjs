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
  is_new: {
    type: DataTypes.BOOLEAN,
  },
  is_top: {
    type: DataTypes.BOOLEAN,
  },
  description: {
    type: DataTypes.STRING,
  },
  images: {
    type: DataTypes.ARRAY(DataTypes.STRING),
  },
  price: {
    type: DataTypes.INTEGER,
  },
  icon: {
    type: DataTypes.STRING,
  },
};

export function Product(sequelize) {
  return sequelize.define("product", productModel, {
    freezeTableName: true,
  });
}
