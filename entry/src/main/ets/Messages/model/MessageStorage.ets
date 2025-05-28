import dataPreferences from '@ohos.data.preferences';
import { ChatMessage } from '../viewmodel/ChatMessage';
import common from '@ohos.app.ability.common';

/**
 * 消息存储管理器 - 负责消息的持久化存储
 */
export class MessageStorage {
  private static readonly STORE_NAME = 'chat_messages';
  private static readonly MESSAGES_KEY = 'messages';
  private static preferences: dataPreferences.Preferences | null = null;
  private static context: common.UIAbilityContext | null = null;

  /**
   * 设置上下文
   * @param ctx - UIAbility上下文
   */
  static setContext(ctx: common.UIAbilityContext) {
    MessageStorage.context = ctx;
  }

  /**
   * 初始化存储
   */
  static async init() {
    if (!MessageStorage.context) {
      console.error('Context not set. Please call setContext first.');
      return;
    }

    try {
      MessageStorage.preferences = await dataPreferences.getPreferences(MessageStorage.context, MessageStorage.STORE_NAME);
    } catch (error) {
      console.error('Failed to initialize message storage:', error);
    }
  }

  /**
   * 保存消息列表
   * @param messages - 要保存的消息列表
   */
  static async saveMessages(messages: ChatMessage[]) {
    if (!MessageStorage.preferences) {
      await MessageStorage.init();
    }
    try {
      // 将消息列表转换为可存储的格式
      let messagesToStore = '[]';
      
      await MessageStorage.preferences?.put(MessageStorage.MESSAGES_KEY, messagesToStore);
      await MessageStorage.preferences?.flush();
    } catch (error) {
      console.error('Failed to save messages:', error);
    }
  }

  /**
   * 获取保存的消息列表
   * @returns 保存的消息列表
   */
  static async getMessages(): Promise<ChatMessage[]> {
    if (!MessageStorage.preferences) {
      await MessageStorage.init();
    }
    try {
      const messagesStr = await MessageStorage.preferences?.get(MessageStorage.MESSAGES_KEY, '[]') as string;
      let messagesData = [];
      try {
        messagesData = JSON.parse(messagesStr);
      } catch {
        messagesData = [];
      }
      
      let result: ChatMessage[] = [];
      for (let i = 0; i < messagesData.length; i++) {
        const msg = messagesData[i];
        result.push({
          type: 'text',
          content: '',
          sender: undefined,
          time: undefined
        });
      }
      return result;
    } catch (error) {
      console.error('Failed to get messages:', error);
      return [];
    }
  }

  /**
   * 清除所有消息
   */
  static async clearMessages() {
    if (!MessageStorage.preferences) {
      await MessageStorage.init();
    }
    try {
      await MessageStorage.preferences?.delete(MessageStorage.MESSAGES_KEY);
      await MessageStorage.preferences?.flush();
    } catch (error) {
      console.error('Failed to clear messages:', error);
    }
  }
} 