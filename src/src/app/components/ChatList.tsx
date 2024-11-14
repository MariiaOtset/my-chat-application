// import { useEffect, useState } from 'react';
// import axios from 'axios';

// const ChatList = () => {
//   const [chats, setChats] = useState([]);

//   useEffect(() => {
//     axios
//       .get('http://localhost:8080/chats') // Адрес вашего серверного API
//       .then((response) => setChats(response.data))
//       .catch((error) => console.error(error));
//   }, []);

//   return (
//     <div className="chat-list">
//       {chats.map((chat) => (
//         <div key={chat.id} className="chat-item">
//           {chat.name}
//         </div>
//       ))}
//     </div>
//   );
// };

// export default ChatList;
