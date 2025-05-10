// MenuItem.ts
export default class MenuItem {
  id: number;
  categoryName: string;

  constructor(id: number, categoryName: string) {
    this.id = id;
    this.categoryName = categoryName;
  }

  // 静态方法：通过id获取categoryName
  static getCategoryNameById(menus: MenuItem[], id: number): string | undefined {
    const foundItem = menus.find(item => item.id === id);
    return foundItem?.categoryName;
  }
}