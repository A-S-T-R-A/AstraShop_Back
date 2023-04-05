import { DataTypes } from "sequelize";

const model = {
  id: {
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  name: {
    type: DataTypes.STRING,
  },
  attribute_type_id: {
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

export function AttributeValues(sequelize) {
  return sequelize.define("attribute_values", model, {
    freezeTableName: true,
  });
}
