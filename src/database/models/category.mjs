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
  parent_category_id: {
    type: DataTypes.INTEGER,
  },
  icon: {
    type: DataTypes.STRING,
  },
  image: {
    type: DataTypes.STRING,
  },
  hru: {
    type: DataTypes.STRING,
  },
};

export function Category(sequelize) {
  return sequelize.define("category", categoryModel, {
    freezeTableName: true,
  });
}
