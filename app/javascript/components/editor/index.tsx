import * as React from "react";
import ReactDOM from "react-dom/client"
import Editor from "./Editor";
import Header from "./Header"

interface AppProps {
  arg: string;
}

const App = ({ arg }: AppProps) => {
  return (
    <div className="editor">
      <Header />
      <Editor />
    </div>
  );
};

document.addEventListener("DOMContentLoaded", () => {
  const rootEl = document.getElementById("editor");
  const root = ReactDOM.createRoot(rootEl)
  root.render(<App arg="Rails 7 with ESBuild" />);
});
