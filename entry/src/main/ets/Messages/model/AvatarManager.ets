/**
 * 头像管理器 - 负责为用户分配和管理头像
 */
export class AvatarManager {
  // 头像资源池
  private static avatarPool: Resource[] = [
    $r('app.media.userA'),
    $r('app.media.userB'),
    $r('app.media.userC'),
    $r('app.media.userD')
  ];
  // 用户头像映射表
  private static userAvatars: Map<string, Resource> = new Map();
  // 已使用的头像索引
  private static usedAvatarIndices: Set<number> = new Set();

  /**
   * 获取用户头像
   * @param userId - 用户ID或名称
   * @returns 用户的头像资源
   */
  static getUserAvatar(userId: string | number): Resource {
    // 将userId转换为字符串作为key
    const userKey = userId.toString();

    // 如果用户已经有头像，直接返回
    const existingAvatar = AvatarManager.userAvatars.get(userKey);
    if (existingAvatar !== undefined) {
      return existingAvatar;
    }

    // 获取一个未使用的头像
    let availableIndices: number[] = [];
    for (let i = 0; i < AvatarManager.avatarPool.length; i++) {
      if (!AvatarManager.usedAvatarIndices.has(i)) {
        availableIndices.push(i);
      }
    }

    // 如果所有头像都被使用了，重置使用状态
    if (availableIndices.length === 0) {
      AvatarManager.usedAvatarIndices.clear();
      availableIndices = [];
      for (let i = 0; i < AvatarManager.avatarPool.length; i++) {
        availableIndices.push(i);
      }
    }

    // 随机选择一个可用头像
    const randomIndex = availableIndices[Math.floor(Math.random() * availableIndices.length)];
    const selectedAvatar = AvatarManager.avatarPool[randomIndex];
    
    // 记录使用情况
    AvatarManager.usedAvatarIndices.add(randomIndex);
    AvatarManager.userAvatars.set(userKey, selectedAvatar);
    
    return selectedAvatar;
  }
} 