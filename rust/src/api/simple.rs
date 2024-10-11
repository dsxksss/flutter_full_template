use sysinfo::System;

use serde::{Deserialize, Serialize};
#[derive(Serialize, Deserialize, Debug)]
pub struct SystemInfo {
    pub(crate) name: String,
    pub(crate) kernel_version: String,
    pub(crate) os_version: String,
    pub(crate) long_os_version: String,
    pub(crate) host_name: String,
    pub(crate) cpu_arch: String,
    pub(crate) distribution_id: String,
    pub(crate) boot_time: u64,
    pub(crate) uptime: u64,
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn os_info() -> String {
    let name = System::name().unwrap();
    let kernel_version = System::kernel_version().unwrap();
    let os_version = System::os_version().unwrap();
    let long_os_version = System::long_os_version().unwrap();
    let host_name = System::host_name().unwrap();
    let cpu_arch = System::cpu_arch().unwrap();
    let distribution_id = System::distribution_id();
    let boot_time = System::boot_time();
    let uptime = System::uptime();
    let info = SystemInfo {
        name,
        kernel_version,
        os_version,
        long_os_version,
        host_name,
        cpu_arch,
        distribution_id,
        boot_time,
        uptime,
    };
    serde_json::to_string(&info).unwrap()
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
