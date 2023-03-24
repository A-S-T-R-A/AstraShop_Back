import { DataTypes } from "sequelize";

const ordersModel = {
  id: {
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  info: {
    type: Sequelize.DataTypes.JSONB,
    allowNull: false,
  },
  createdAt: {
    type: DataTypes.DATE,
  },
  updatedAt: {
    type: DataTypes.DATE,
  },
};

export function Product(sequelize) {
  return sequelize.define("orders", ordersModel, {
    freezeTableName: true,
  });
}
