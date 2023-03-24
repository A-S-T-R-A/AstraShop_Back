import { DataTypes } from "sequelize";

export const categoryFiltersModel = {
  id: {
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
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
  info: {
    type: DataTypes.JSONB,
    allowNull: true,
  },
};

export function CategoryFilters(sequelize) {
  return sequelize.define("category_filters", categoryFiltersModel, {
    freezeTableName: true,
  });
}
