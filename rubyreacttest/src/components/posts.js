import React from 'react';

function Posts({ props, onDelete }) {
    return (
        <div>
            <h1>Posts are from API</h1>
            {props.map((post) => {
                return <div key={post.id}>
                    <h2>{post.post_title}</h2>
                    <p>{post.post_body}</p>
                    <button onClick={() => onDelete(post.id)}>Delete</button>
                    </div>
            })}
        </div>
    )
}

export default Posts