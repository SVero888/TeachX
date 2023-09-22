import { AuthClient } from "@dfinity/auth-client";
import React, { createContext, useContext, useEffect, useState } from "react";
import { canisterId, createActor } from "./declarations/whoami";

interface AuthOptions {
  createOptions: import("@dfinity/auth-client").AuthClientCreateOptions;
  loginOptions: import("@dfinity/auth-client").AuthClientLoginOptions;
}

const AuthContext = createContext<any>(null); // Define el tipo de contexto

const defaultOptions: AuthOptions = {
  createOptions: {
    idleOptions: {
      disableIdle: true,
    },
  },
  loginOptions: {
    identityProvider:
      process.env.DFX_NETWORK === "ic"
        ? "https://identity.ic0.app/#authorize"
        : `http://localhost:4943?canisterId=be2us-64aaa-aaaaa-qaabq-cai#authorize`,
  },
};

export const useAuthClient = (options: AuthOptions = defaultOptions) => {
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(false);
  const [authClient, setAuthClient] = useState<AuthClient | null>(null);
  const [identity, setIdentity] = useState<any>(null); // Ajusta el tipo según tu lógica
  const [principal, setPrincipal] = useState<any>(null); // Ajusta el tipo según tu lógica
  const [whoamiActor, setWhoamiActor] = useState<any>(null); // Ajusta el tipo según tu lógica

  useEffect(() => {
    AuthClient.create(options.createOptions).then(async (client) => {
      updateClient(client);
    });
  }, []);

  const login = () => {
    authClient?.login({
      ...options.loginOptions,
      onSuccess: () => {
        updateClient(authClient);
      },
    });
  };

  async function updateClient(client: AuthClient) {
    const isAuthenticated = await client.isAuthenticated();
    setIsAuthenticated(isAuthenticated);

    const identity = client.getIdentity();
    setIdentity(identity);

    const principal = identity.getPrincipal();
    setPrincipal(principal);

    setAuthClient(client);

    const actor = createActor(canisterId, {
      agentOptions: {
        identity,
      },
    });

    setWhoamiActor(actor);
  }

  async function logout() {
    await authClient?.logout();
    await updateClient(authClient!); // El operador '!' indica que no será nulo
  }

  return {
    isAuthenticated,
    login,
    logout,
    authClient,
    identity,
    principal,
    whoamiActor,
  };
};

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const auth = useAuthClient();

  return <AuthContext.Provider value={auth}>{children}</AuthContext.Provider>;
};

export const useAuth = () => useContext(AuthContext);
