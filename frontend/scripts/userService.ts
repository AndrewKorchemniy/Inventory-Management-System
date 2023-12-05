import Axios from "axios";

export class UserService {
  static id = "";
  static key = "";
  static username = "";
  static isLoggedIn = false;

  static async login(id: string, key: string): Promise<boolean> {
    UserService.id = id;
    try {
      const result = await Axios.get("/Username", {
        headers: {
          "Ocp-Apim-Subscription-Key": key,
        },
        params: {
          id,
        },
      });
      if (result.status === 200) {
        UserService.id = id;
        UserService.key = key;
        UserService.isLoggedIn = true;
        return true;
      }
      console.error(result.statusText);
    } catch (error) {
      console.error(error);
    }
    return false;
  }
}
