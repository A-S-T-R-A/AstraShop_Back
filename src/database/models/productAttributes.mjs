import { DataTypes } from "sequelize";

const model = {
  id: {
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  product_attribute_value_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  product_id: {
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

export function ProductAttributes(sequelize) {
  return sequelize.define("product_attributes", model, {
    freezeTableName: true,
  });
}
