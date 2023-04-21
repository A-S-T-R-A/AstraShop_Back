import { DataTypes } from "sequelize";

export const categoryAttributesModel = {
  id: {
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  attribute_type_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  category_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  createdAt: {
    type: DataTypes.DATE,
  },
  updatedAt: {
    type: DataTypes.DATE,
  },
};

export function CategoryAttributes(sequelize) {
  return sequelize.define("category_attributes", categoryAttributesModel, {
    freezeTableName: true,
  });
}
