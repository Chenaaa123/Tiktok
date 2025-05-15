export interface PrivateMessage {
  id: number;
  name: string;
  msg: string;
  unread: number;
  comments: Comment[];
  time: string;
}


export interface Comment {
  id: number;
  user: string;
  content: string;
  time: string;
}

export interface Mention {
  id: number;
  user: string;
  content: string;
  time: string;
}

