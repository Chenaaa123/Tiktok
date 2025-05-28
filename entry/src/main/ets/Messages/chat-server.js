const net = require('net');
const readline = require('readline');

// 配置服务器
const HOST = '0.0.0.0'; // 监听所有网络接口
const PORT = 8080;      // 服务器端口

// 存储所有客户端连接
const clients = new Map();
let clientIdCounter = 1;

// 创建服务器控制台输入接口
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// http.createHttp() //
// 创建TCP服务器
const server = net.createServer((socket) => {
    // 为每个客户端分配唯一ID
    const clientId = clientIdCounter++;
    // 客户端的信息(ip地址、端口)
    const clientInfo = `${socket.remoteAddress}:${socket.remotePort} (ID: ${clientId})`;

    console.log(`[新连接] 客户端 ${clientInfo} 已连接`);

    // 保存客户端连接
    clients.set(clientId, {
        socket: socket,
        info: clientInfo
    });

    // 向新连接的客户端发送欢迎消息
    const welcomeMsg = JSON.stringify({
        type: 'system',
        content: `欢迎连接到聊天服务器，您的ID是: ${clientId}`,
        time: Date.now()
    });
    socket.write(welcomeMsg + '\n');

    // 广播新用户加入消息
    broadcastMessage({
        type: 'system',
        content: `客户端 ${clientId} 加入了聊天室`,
        time: Date.now()
    }, clientId);

    // 接收客户端消息
    let buffer = '';
    socket.on('data', (data) => {
        // 将数据追加到缓冲区
        buffer += data.toString();

        // 处理可能一次收到多条消息的情况
        let endIndex;
        while ((endIndex = buffer.indexOf('\n')) !== -1) {
            const messageStr = buffer.substring(0, endIndex);
            buffer = buffer.substring(endIndex + 1);

            try {
                const message = JSON.parse(messageStr);
                console.log(`[收到消息] 来自客户端 ${clientInfo}:`);
                console.log(`  类型: ${message.type}`);
                console.log(`  内容: ${message.content}`);

                // 为消息添加sender信息并广播
                message.sender = clientId;
                message.time = Date.now();
                broadcastMessage(message);
            } catch (err) {
                console.error(`[错误] 解析消息失败: ${messageStr}`);
                console.error(err);
            }
        }
    });

    // 处理客户端断开连接
    socket.on('close', () => {
        console.log(`[断开连接] 客户端 ${clientInfo} 断开连接`);
        clients.delete(clientId);

        // 广播用户离开消息
        broadcastMessage({
            type: 'system',
            content: `客户端 ${clientId} 离开了聊天室`,
            time: Date.now()
        });

        console.log(`[状态] 当前连接数: ${clients.size}`);
    });

    // 处理错误
    socket.on('error', (err) => {
        console.error(`[错误] 客户端 ${clientInfo} 发生错误:`);
        console.error(err);
    });

    console.log(`[状态] 当前连接数: ${clients.size}`);
});

// 广播消息给所有客户端
function broadcastMessage(message, excludeClientId = null) {
    const messageStr = JSON.stringify(message) + '\n';

    clients.forEach((client, id) => {
        if (excludeClientId !== null && id === excludeClientId) {
            return; // 排除指定客户端
        }

        try {
            client.socket.write(messageStr);
        } catch (err) {
            console.error(`[错误] 向客户端 ${client.info} 发送消息失败:`);
            console.error(err);
        }
    });
}

// 发送消息给指定客户端
function sendMessageToClient(clientId, message) {
    if (!clients.has(clientId)) {
        console.error(`[错误] 客户端ID ${clientId} 不存在`);
        return false;
    }

    const client = clients.get(clientId);
    const messageStr = JSON.stringify(message) + '\n';

    try {
        client.socket.write(messageStr);
        return true;
    } catch (err) {
        console.error(`[错误] 向客户端 ${client.info} 发送消息失败:`);
        console.error(err);
        return false;
    }
}

// 启动服务器
server.listen(PORT, HOST, () => {
    console.log(`聊天服务器已启动，监听地址: ${HOST}:${PORT}`);
    console.log('---------------------------------------------');
    console.log('[服务器命令帮助]');
    console.log('broadcast <message> - 广播消息给所有客户端');
    console.log('send <clientId> <message> - 发送消息给指定客户端');
    console.log('list - 列出所有连接的客户端');
    console.log('exit - 关闭服务器');
    console.log('---------------------------------------------');
    console.log('服务器日志:');

    // 设置命令处理
    setupCommandInterface();
});

// 设置命令行交互
function setupCommandInterface() {
    rl.on('line', (input) => {
        const args = input.trim().split(' ');
        const command = args[0].toLowerCase();

        switch (command) {
            case 'broadcast':
                // 广播消息给所有客户端
                if (args.length < 2) {
                    console.log('[命令错误] 用法: broadcast <message>');
                    break;
                }
                const broadcastContent = args.slice(1).join(' ');
                const broadcastMsg = {
                    type: 'text',
                    content: broadcastContent,
                    sender: 'server',
                    time: Date.now()
                };
                broadcastMessage(broadcastMsg);
                console.log(`[广播] 已向所有客户端广播消息: ${broadcastContent}`);
                break;

            case 'send':
                // 发送消息给指定客户端
                if (args.length < 3) {
                    console.log('[命令错误] 用法: send <clientId> <message>');
                    break;
                }
                const targetClientId = parseInt(args[1]);
                const messageContent = args.slice(2).join(' ');

                if (isNaN(targetClientId)) {
                    console.log('[命令错误] 客户端ID必须是一个数字');
                    break;
                }

                const directMsg = {
                    type: 'text',
                    content: messageContent,
                    sender: 'server',
                    time: Date.now()
                };

                const success = sendMessageToClient(targetClientId, directMsg);
                if (success) {
                    console.log(`[发送] 已向客户端 ${targetClientId} 发送消息: ${messageContent}`);
                }
                break;

            case 'list':
                // 列出所有连接的客户端
                if (clients.size === 0) {
                    console.log('[列表] 当前没有客户端连接');
                } else {
                    console.log('[列表] 当前连接的客户端:');
                    clients.forEach((client, id) => {
                        console.log(`  ID: ${id}, 地址: ${client.info}`);
                    });
                }
                break;

            case 'exit':
                // 关闭服务器
                console.log('正在关闭服务器...');
                shutdownServer();
                break;

            case 'help':
                // 显示帮助信息
                console.log('[服务器命令帮助]');
                console.log('broadcast <message> - 广播消息给所有客户端');
                console.log('send <clientId> <message> - 发送消息给指定客户端');
                console.log('list - 列出所有连接的客户端');
                console.log('exit - 关闭服务器');
                break;

            default:
                console.log(`[命令错误] 未知命令: ${command}`);
                console.log('输入 "help" 查看可用命令');
        }
    });
}

// 关闭服务器
function shutdownServer() {
    // 关闭所有客户端连接
    clients.forEach((client) => {
        try {
            const disconnectMsg = JSON.stringify({
                type: 'system',
                content: '服务器已关闭',
                time: Date.now()
            }) + '\n';
            client.socket.write(disconnectMsg);
            client.socket.end();
        } catch (err) {
            // 忽略错误
        }
    });

    // 关闭服务器
    server.close(() => {
        console.log('服务器已关闭');
        rl.close();
        process.exit(0);
    });
}

// 处理服务器错误
server.on('error', (err) => {
    console.error('[服务器错误]', err);
});

// 处理进程终止
process.on('SIGINT', () => {
    console.log('\n检测到Ctrl+C，正在关闭服务器...');
    shutdownServer();
});