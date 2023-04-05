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

export function AttributeTypes(sequelize) {
  return sequelize.define("attribute_types", model, {
    freezeTableName: true,
  });
}
