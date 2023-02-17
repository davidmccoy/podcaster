import * as React from "react";
import ReactDOM from "react-dom/client"
import Editor from "./Editor";

interface AppProps {
  arg: string;
}

const App = ({ arg }: AppProps) => {
  return (
    <div className="editor">
      <Editor />
    </div>
  );
};

document.addEventListener("turbo:load", () => {
  const rootEl = document.getElementById("editor");
  if (rootEl) {
    const root = ReactDOM.createRoot(rootEl)
    root.render(<App arg="Rails 7 with ESBuild" />);
  }
});
