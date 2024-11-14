struct CreateChat: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("chats")
            .id()
            .field("name", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("chats").delete()
    }
}
