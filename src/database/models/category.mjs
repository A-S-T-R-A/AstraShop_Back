import { DataTypes } from "sequelize";

export const categoryModel = {
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

export function Category(sequelize) {
  console.log(11);
  return sequelize.define("category", categoryModel, {
    freezeTableName: true,
  });
}
