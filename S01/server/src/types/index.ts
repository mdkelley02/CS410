export type DaoCallback = (err: Error, result: any) => void;

export type Config = {
  port: string;
  db: {
    host: string;
    user: string;
    password: string;
    database: string;
    port: string;
  };
};

export type MysqlConnection = any;
