import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("chats") { req -> EventLoopFuture<[Chat]> in
        return Chat.query(on: req.db).all()
    }

    app.post("chats") { req -> EventLoopFuture<Chat> in
        let chat = try req.content.decode(Chat.self)
        return chat.save(on: req.db).map { chat }
    }

    app.delete("chats", ":chatID") { req -> EventLoopFuture<HTTPStatus> in
        let chatID = try req.parameters.require("chatID", as: UUID.self)
        return Chat.find(chatID, on: req.db)
            .flatMap { chat in
                guard let chat = chat else {
                    throw Abort(.notFound)
                }
                return chat.delete(on: req.db)
            }
            .transform(to: .ok)
    }

    app.get("chats", ":chatID", "messages") { req -> EventLoopFuture<[Message]> in
        let chatID = try req.parameters.require("chatID", as: UUID.self)
        return Message.query(on: req.db).filter(\.$chat.$id == chatID).all()
    }

    app.post("chats", ":chatID", "messages") { req -> EventLoopFuture<Message> in
        let chatID = try req.parameters.require("chatID", as: UUID.self)
        let message = try req.content.decode(Message.self)
        message.$chat.id = chatID
        return message.save(on: req.db).map { message }
    }

    try app.register(collection: TodoController())
}
