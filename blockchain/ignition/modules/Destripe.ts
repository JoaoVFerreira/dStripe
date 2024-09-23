import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const DestripeModule = buildModule("DestripeModule", (m) => {
  const destripeCoin = m.contract("DestripeCoin");
  const destripeCollection = m.contract("DestripeCollection");
  const destripe = m.contract("Destripe", [destripeCoin, destripeCollection]);

  m.call(destripeCollection, "setAuthorizedContract", [destripe]);

  return { destripe, destripeCoin, destripeCollection };
});

export default DestripeModule;
