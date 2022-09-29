import { useCallback, useEffect, useState } from "react";
import "./App.css";
import reactLogo from "./assets/react.svg";

function App() {
  const [eventName, setEventName] = useState("");
  const [currentEventName, setCurrentEventName] = useState<string>();
  const [iOSEventName, setIOSEventName] = useState("");
  const [iOSData, setIOSData] = useState(
    JSON.stringify(
      { status: "call_end", message: "Your hearing has ended" },
      null,
      2
    )
  );

  const createCustomEvent = () => {
    const eventFunc = (e: any) => {
      console.log(`Custom event ${eventName} fired with data: ${e}`);
      console.log(`JSON stringifying the data...`);
      alert(`Custom event ${eventName} fired with data: ${JSON.stringify(e)}`);
    };

    if (currentEventName) {
      window.removeEventListener(currentEventName, eventFunc);
      console.log(`Successfully removed event: ${currentEventName}`);
    }
    window.addEventListener(eventName, eventFunc);
    console.log(`Successfully created event: ${eventName}`);
    setCurrentEventName(eventName);
  };

  const handleSendToiOS = () => {
    console.log(`Sending event: ${iOSEventName} with data: ${iOSData}`);
    // @ts-ignore
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
        placeholder="paste valid JSON here to send to iOS"
        onChange={({ target }) => setIOSData(target.value)}
      />
      <button onClick={handleSendToiOS}>Send to iOS</button>
    </div>
  );
}

export default App;
