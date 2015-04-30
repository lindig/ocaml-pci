open Ctypes

module B = Pci_bindings.Bindings(Pci_generated)

type pci_access = B.pci_access structure ptr
type pci_dev = B.pci_dev structure ptr

let pci_alloc = B.pci_alloc
let pci_init = B.pci_init
let pci_cleanup = B.pci_cleanup
let pci_scan_bus = B.pci_scan_bus

let get_devices pci_access =
  let rec list_of_linked_list acc = function
  | None -> acc
  | Some d -> list_of_linked_list (d::acc) (getf !@d B.next) in
  list_of_linked_list [] (getf !@pci_access B.devices)

let vendor_id d = getf !@d B.vendor_id |> Unsigned.UInt16.to_int