import logo from './logo.svg';
import './App.css';
import axios from "axios";
import Posts from "./components/posts";
import { useEffect, useState } from "react"

const API_URL = "http://localhost:3000/posts";

function getApiData() {
  return axios.get(API_URL).then((response) => response.data)
}

function App() {
  const [posts, setPosts] = useState([]);
  useEffect(() => {
    let mounted = true;
    getApiData().then((items) => {
      if (mounted) {
        setPosts(items);
      }
    });
    return () => {(mounted = false)}
  }, []);

  const handleDelete = (id) => {
    // Only remove the post locally (no API call)
    setPosts(posts.filter(post => post.id !== id));
  };

  return (
    <div className="App">
      <h1>Hello</h1>
      <Posts props={posts} onDelete={handleDelete} />
    </div>
  );
}

export default App;
