export class StorageService {
  private static get(key: string): string {
    return (window && localStorage.getItem(key)) || "";
  }

  private static set(key: string, value: string): void {
    window && localStorage.setItem(key, value);
  }

  static setId(id: string): void {
    this.set("inventory-id", id);
  }

  static getId(): string {
    return this.get("inventory-id");
  }
}
