struct CreateMessage: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("messages")
            .id()
            .field("text", .string, .required)
            .field("chat_id", .uuid, .required)
            .foreignKey("chat_id", references: "chats", "id")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("messages").delete()
    }
}
