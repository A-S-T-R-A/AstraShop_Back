module.exports = {
  development: {
    database: "ecommerce",
    username: "postgres",
    password: "docker",
    host: "localhost",
    dialect: "postgres",
    port: 5432,
  },
  production: {
    database: "ecommerce",
    username: "admin",
    password: "1",
    host: "localhost",
    dialect: "postgres",
    port: 5432,
  },
};
