import { useCallback, useEffect, useState } from "react";
import "./App.css";
import reactLogo from "./assets/react.svg";

function App() {
  const [eventName, setEventName] = useState("");
  const [currentEventName, setCurrentEventName] = useState("");
  const [iOSEventName, setIOSEventName] = useState("");
  const [iOSData, setIOSData] = useState("");

  const createCustomEvent = () => {
    const func = (e: any) => alert(JSON.stringify(e));

    window.removeEventListener(currentEventName, func);
    window.addEventListener(eventName, func);
    setCurrentEventName(eventName);
  };

  const handleSendToiOS = () => {
    window?.webkit?.messageHandlers[iOSEventName]?.postMessage(
      JSON.parse(iOSData)
    );
  };

  return (
    <div className="App">
      <h2 className="title">JS</h2>
      <input
        value={eventName}
        placeholder="Enter event name for JS"
        onChange={({ target }) => setEventName(target.value)}
      />
      <button onClick={createCustomEvent}>Create event in JS</button>
      <h2 className="title">iOS</h2>
      <input
        value={iOSEventName}
        placeholder="Enter event name for iOS"
        onChange={({ target }) => setIOSEventName(target.value)}
      />
      <textarea
        value={iOSData}
        defaultValue={JSON.stringify(
          { status: "call_end", message: "Your hearing has ended" },
          null,
          2
        )}
        placeholder="paste valid JSON here to send to iOS"
        onChange={({ target }) => setIOSData(target.value)}
      />
      <button onClick={handleSendToiOS}>Send to iOS</button>
    </div>
  );
}

export default App;
