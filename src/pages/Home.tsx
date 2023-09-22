import { SetStateAction, useState } from "react";
import { useAuth } from "../use-auth-client";

export default function Home() {
  const { isAuthenticated, identity, login } = useAuth();

  const [result, setResult] = useState("");
  const { whoamiActor, logout } = useAuth();

  const handleClick = async () => {
    const whoami = await whoamiActor.whoami();
    setResult(whoami);
  };

  const whoamiStyles = {
    border: "1px solid #1a1a1a",
    marginBottom: "1rem",
  };

  return (
    <>
      Home
    </>
  );
}