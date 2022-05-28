import BorrowerDao from "../../dao/borrowerDao";

export default class BorrowerController {
  // returns all borrowers
  static getAll = async (req: any, res: any) => {
    BorrowerDao.getAll((err: any, result: any) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.status(200).send(result);
      }
    });
  };
}
